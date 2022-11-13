class TradesController < ApplicationController
    before_action :initialize_stock, only: [:find_stock, :buy_stock]

    def find_stock
        begin
            quote = @client.quote(params[:search_stock])
            redirect_to buy_stock_path(params[:search_stock]) # '/buy_stock/GOOGL'
        rescue IEX::Errors::SymbolNotFoundError
            flash[:error] = "Sorry, the symbol is not valid."
            render :find_stock 
        end
    end

    def sell_stock
       
    end

    def buy_stock
        begin
            @quote = @client.quote(params[:symbol])
            @stock = Stock.new

        rescue IEX::Errors::SymbolNotFoundError
            flash[:error] = "Sorry, the symbol is not valid."
            render :find_stock 
        end
    end

    private

    def initialize_stock
        @client = IEX::Api::Client.new( publishable_token: 'pk_d10cc347da074a029aa3f948a7dc4e47', secret_token: 'sk_3d7f3084534a4f2fb80218e34f340b64', endpoint: 'https://cloud.iexapis.com/v1')
    end
    
    def stock_params
        params.require(:stock).permit(:symbol, :company_name, :shares, :cost_price)
        # params.require(:stock).permit(:shares)
    end
end
