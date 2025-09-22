class Api::MealsController < ApplicationController
  # 全アクションでユーザー認証を実行
  before_action :authenticate_user!
  # show, update, destroy 実行前に対象の Meal を取得
  before_action :set_meal, only: [:show, :update, :destroy]

  # 指定日（デフォルトは今日）の食事一覧を返す
  def index
    date = (params[:eaten_on].presence || Date.current).to_date
    meals = current_user.meals.where(eaten_on: date).order(:kind, :created_at)
    render json: meals.as_json(only: [:id,:eaten_on,:kind,:name,:amount_grams,:calories_kcal,:notes])
  end

  # 特定の食事データを返す
  def show
    render json: @meal.as_json(only: [:id,:eaten_on,:kind,:name,:amount_grams,:calories_kcal,:notes])
  end
  # 新しい食事を作成
  def create
    meal = current_user.meals.new(meal_params)
    meal.eaten_on ||= Date.current
    if meal.save
      render json: meal.as_json(only: [:id,:eaten_on,:kind,:name,:amount_grams,:calories_kcal,:notes]), status: :created
    else
      render json: { errors: meal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 既存の食事データを更新
  def update
    if @meal.update(meal_params)
      render json: @meal.as_json(only: [:id,:eaten_on,:kind,:name,:amount_grams,:calories_kcal,:notes])
    else
      render json: { errors: @meal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # 食事データを削除
  def destroy
    @meal.destroy
    head :no_content
  end

  # 指定された ID の食事を現在のユーザーから検索
  private
  def set_meal
    @meal = current_user.meals.find(params[:id])
  end

  #許可する項目を制限
  def meal_params
    params.require(:meal).permit(:eaten_on, :kind, :name, :amount_grams, :calories_kcal, :notes)
  end
end
