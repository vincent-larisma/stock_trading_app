class StocksController < ApplicationController
    def index
        @stocks = Stock.all
    end

    def new
        @stock = Stock.new
    end

    def create
        @stock = Stock.find_or_create_by(symbol: params[:symbol]) 

        if @stock.update(stock_params)
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
