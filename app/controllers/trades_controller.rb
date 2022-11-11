class TradesController < ApplicationController
    def find_stock
        client = IEX::Api::Client.new( publishable_token: 'pk_d10cc347da074a029aa3f948a7dc4e47', secret_token: 'sk_3d7f3084534a4f2fb80218e34f340b64', endpoint: 'https://cloud.iexapis.com/v1')
        symbols = client.ref_data_symbols
        
        if params[:search_stock]
            symbols.each do |symbol|
                if symbol.symbol == params[:search_stock]
                    redirect_to buy_stock_path(params[:search_stock])
                end
            end
        end
        
    end

    def sell_stock

    end

    def buy_stock

    end
    
end
