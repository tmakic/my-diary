require "date"

class EventsController < ApplicationController
    # 初期ページを表示(当日のイベントを表示)
    def index
        @events = Event.all
        @date = today
        @selected_date_event = selected_date_event(today)
    end

    # イベント新規作成ページを表示
    def new
        @event = Event.new
        @exercises = Exercise.all
        @action = :create
        @button_text = "登録"
    end

    # イベントを新規作成
    def create
        Event.create(event_parameter)
        redirect_to events_url
    end

    # 特定の日付のページを表示（特定の日のイベントを表示)
    def show
        @events = Event.all
        @date = params[:id]
        @selected_date_event = selected_date_event(@date)
    end

    # イベントページを表示
    def edit
        @date = params[:id]
        @event = selected_date_event(@date)
        @action = :update
        @button_text = "更新"
    end

    # イベントを編集した内容に更新
    def update
        @date = params[:id]
        @selected_date_event = selected_date_event(@date)
        
        if @selected_date_event.update_attributes(event_parameter)
            redirect_to event_path(@date)
        else
            render 'edit'
        end
    end

    # イベント削除確認ページを表示
    def delete_confirm
        @date = params[:id]
        @selected_date_event = selected_date_event(@date)
    end

    # イベントを削除
    def destroy
        @date = params[:id]
        @selected_date_event = selected_date_event(@date)
        if (@selected_date_event)
            @selected_date_event.destroy
        end
        redirect_to events_path
    end

    helper_method :is_exercise_complete

    private

    # イベントのパラメータ
    # @return [ActiveRecord::Relation] パラメータ
    def event_parameter
        params.require(:event).permit(:title, :done, :achievement, :memo, :start_time, { :exercise_ids => [] })
    end

    # 今日の日付
    # @return [Date] date 日付
    def today
        Date.today
    end

    # 日付に紐づくイベントのうち、最初の1件を抽出
    # @param [String] 日付
    # @return [ActiveRecord::Relation] イベント情報
    def selected_date_event(date)
        Event.where('start_time like ?', "#{date}%").first
    end

    # 筋トレ全て実施したか
    # @param [ActiveRecord::Relation] イベント情報
    # @param [nil] イベント未登録の場合nil
    # @return [Boolean] 全部実施 → true
    def is_exercise_complete(event)
        if event.nil?
            return false
        end

        @all_exercises = Exercise.all
        @event_exercises = event.exercises
        @all_exercises.all? { |v|
            # findだと見つからないとき例外が発生するのでfind_by
            @event_exercises.find_by(id: v)
        }
    end
end
