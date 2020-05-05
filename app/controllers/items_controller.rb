class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    # rakuten_web_service内のclassで使えるようにアプリケーションIDを設定
    RakutenWebService.configure do |c|
      c.application_id = 1008590106441031375
    end
    
    # ARGV[0]で実行時の1つめのパラメータを取得、存在しない場合は'Ruby'を設定
    keyword = ARGV[0] || 'soccerball'
    
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
    
    #未追加の商品をお気に入りした時
    if params[:num] == '1'
      if @item.save
        redirect_to item_reviews_path(@item)
      else
        flash.now[:danger] = '商品登録に失敗しました。'
        redirect_back(fallback_location: root_path)
      end
    #未追加の商品をレビューする時
    else
      if @item.save
        current_user.favorite(@item)
        flash[:success] = '商品をお気に入りしました'
        redirect_back(fallback_location: root_path)
      else
        flash.now[:danger] = 'お気に入り出来ませんでした'
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
  end
  
  def fav_ranking
    @fav_items = Item.create_fav_ranking
    #@favitemsranking = Kaminari.paginate_array(@fav_items).page(params[:page]).per(10)
  end
  
  def rev_ranking
    @rev_items = Item.create_rev_ranking
  end
  
  private

  def item_params
    params.require(:item).permit(:image, :name, :price, :content, :item_code)
  end
end
