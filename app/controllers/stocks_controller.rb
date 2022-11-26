class StocksController < ApplicationController
    before_action :authenticate_user!, :is_approved?
    before_action :initialize_stock, :initialize_searched_stock, only: [:create, :update]

    rescue_from IEX::Errors::SymbolNotFoundError, with: :not_valid_symbol

    def index
        @stocks = current_user.stocks.bought_stock
        @previous_stocks = current_user.stocks.previously_bought_stock
    end

    def create
        @stock.shares += stock_params[:shares].to_i
        @stocks_bought = stock_params[:shares].to_i
        
        if @stock.save
            current_user.transactions.create(action_type: 'buy', company_name: @quote.company_name, shares: @stock.shares, cost_price: @quote.latest_price)
            redirect_to root_path
            ApproveEmailMailer.buy_stocks(current_user, @stock, @stocks_bought).deliver_now
        else
            redirect_to find_stock_path
        end
    end

    def update
        @stock.shares -= stock_params[:shares].to_i
        @stocks_sold = stock_params[:shares].to_i
        
        if @stock.shares.to_i >= 0

            @stock.save
            current_user.transactions.create(action_type: 'sell', company_name: @quote.company_name, shares: @stock.shares, cost_price: @quote.latest_price)
            ApproveEmailMailer.sold_stocks(current_user, @stock, @stocks_sold).deliver_now
            redirect_to root_path
        elsif @stock.shares.to_i < 0
            flash[:error] = "Sorry, cannot be negative."
            redirect_to sell_stock_path(params[:symbol])
        end
    end

    private
    def initialize_stock
        @client = IEX::Api::Client.new( publishable_token: 'pk_d10cc347da074a029aa3f948a7dc4e47', secret_token: 'sk_3d7f3084534a4f2fb80218e34f340b64', endpoint: 'https://cloud.iexapis.com/v1')
    end

    def stock_params
        params.require(:stock).permit(:symbol, :company_name, :shares, :cost_price)
    end

    def initialize_searched_stock #manually add params
        @quote = @client.quote(params[:symbol])
        @stock = current_user.stocks.find_or_initialize_by(symbol: params[:symbol])   
            
        @stock.symbol = @quote.symbol
        @stock.company_name = @quote.company_name 
        @stock.cost_price = @quote.latest_price
    end
end
