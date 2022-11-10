class StocksController < ApplicationController
    # before_action :authenticate_user!
    def index
        @stocks = Stock.all
    end

    def new
        @stock = Stock.new
    end

    def create
        @stock = Stock.find_or_initialize_by(symbol: stock_params[:symbol])
        @stock.shares += stock_params[:shares].to_i

        if @stock.update(stock_params.except(:shares))
            @stock.transactions.create(action_type: 'buy', company_name: @stock.company_name, shares: @stock.shares, cost_price: @stock.cost_price)
            redirect_to root_path
        else
            render :new
        end
    end

    private

    def stock_params
        params.require(:stock).permit(:symbol, :company_name, :shares, :cost_price)
    end

end
