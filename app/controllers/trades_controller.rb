class TradesController < ApplicationController
    before_action :authenticate_user!, :is_approved?, :initialize_stock
    before_action :initialize_trade_info, only: [:buy_stock, :sell_stock]

    rescue_from IEX::Errors::SymbolNotFoundError, with: :not_valid_symbol

    def find_stock
        if params[:search_stock]
            quote = @client.quote(params[:search_stock])
            redirect_to buy_stock_path(params[:search_stock]) # '/buy_stock/GOOGL'
        end
    end

    def sell_stock
        @stock = current_user.stocks.find_by(symbol: params[:symbol]) #goes to update controller action
    end

    def buy_stock
        @stock = current_user.stocks.build #goes to create controller action
    end

    private

    def initialize_stock
        @client = IEX::Api::Client.new( publishable_token: 'pk_d10cc347da074a029aa3f948a7dc4e47', secret_token: 'sk_3d7f3084534a4f2fb80218e34f340b64', endpoint: 'https://cloud.iexapis.com/v1')
    end

    def initialize_trade_info #buy & sell info (trade action)
        @quote = @client.quote(params[:symbol])
        @user_stock_shares = current_user.stocks.shares_by(params[:symbol])
    end
    
    def stock_params
        params.require(:stock).permit(:symbol, :company_name, :shares, :cost_price)
    end
end
