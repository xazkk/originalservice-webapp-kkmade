class ItemsController < ApplicationController
  def index
    # rakuten_web_service内のclassで使えるようにアプリケーションIDを設定
    RakutenWebService.configure do |c|
      c.application_id = 1008590106441031375
    end
    
    # ARGV[0]で実行時の1つめのパラメータを取得、存在しない場合は'Ruby'を設定
    keyword = ARGV[0] || 'basketball'
    
    # rakuten_web_serviceの使用法に乗っ取りHTTPリクエストを送ってデータを取得
    @Ritems = RakutenWebService::Ichiba::Item.search(keyword: keyword)
    # 取得したデータを10件まで表示
    #items.first(10).each do |item|
      #puts "#{item['itemName']}, #{item.price} yen"
    #end
    
    @items = Item.order(id: :desc)
  end
  
  def create
    @item = Item.new(image: params[:image], name: params[:name], 
                     price: params[:price], content: params[:content], item_code: params[:item_code])
    
    if @item.save
      current_user.favorite(@item)
      flash[:success] = '商品をお気に入りしました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = '商品登録に失敗しました。お気に入り出来ませんでした'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end
  
  def ranking
    @fav_items = Item.create_fav_ranking
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :content, :item_code)
  end
end
