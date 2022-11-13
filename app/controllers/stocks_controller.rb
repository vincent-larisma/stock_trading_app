class StocksController < ApplicationController
    # before_action :authenticate_user!
    before_action :initialize_stock, only: [:create]

    def index
        @stocks = Stock.all
    end

    def new
        @stock = Stock.new
    end

    def create
        begin
            
            @quote = @client.quote(params[:symbol])
            @stock = Stock.find_or_initialize_by(symbol: params[:symbol])

            #manually add params
            @stock.shares += stock_params[:shares].to_i
            @stock.symbol = @quote.symbol
            @stock.company_name = @quote.company_name 
            @stock.cost_price = @quote.latest_price

            if @stock.save
                @stock.transactions.create(action_type: 'buy', company_name: @quote.company_name, shares: @stock.shares, cost_price: @quote.latest_price)
                redirect_to root_path
            else
                redirect_to find_stock_path
            end

        rescue IEX::Errors::SymbolNotFoundError
            flash[:error] = "Sorry, the symbol is not valid."
            redirect_to find_stock_path
        end
    end

    private
    def initialize_stock
        @client = IEX::Api::Client.new( publishable_token: 'pk_d10cc347da074a029aa3f948a7dc4e47', secret_token: 'sk_3d7f3084534a4f2fb80218e34f340b64', endpoint: 'https://cloud.iexapis.com/v1')
    end

    def stock_params
        params.require(:stock).permit(:symbol, :company_name, :shares, :cost_price)
    end

end
