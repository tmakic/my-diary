require "date"

class EventsController < ApplicationController
    # 初期ページを表示(当日のイベントを表示)
    def index
        @events = Event.all
        @date = today
        @selected_date_event = selected_date_event(today)
        @exercise_check_status = exercise_check_status(@selected_date_event)
    end

    # イベント新規作成ページを表示
    def new
        @event = Event.new
    end

    # イベントを新規作成する
    def create
        Event.create(event_parameter)
        redirect_to events_url
    end

    # 特定の日付のページを表示（特定の日のイベントを表示)
    def show
        @events = Event.all
        @date = params[:id]
        @selected_date_event = selected_date_event(@date)
        @exercise_check_status = exercise_check_status(@selected_date_event)
    end

    # イベントページを表示
    def edit
        @date = params[:id]
        @selected_date_event = selected_date_event(@date)
        @exercise_check_status = exercise_check_status(@selected_date_event)
    end

    # イベントを編集した内容に更新する
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
        @exercise_check_status = exercise_check_status(@selected_date_event)
    end

    # イベントを削除
    def destroy
        # ここに入ってこない
        debugger
    end

    helper_method :is_exercise_complete

    private

    # イベントのパラメータ
    # @return [ActiveRecord::Relation] パラメータ
    def event_parameter
        params.require(:event).permit(:title, :done, :achievement, :memo, :start_time, exercise: [])
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

    # 筋トレ実施状況をハッシュに整形
    # @param [ActiveRecord::Relation] イベント情報
    # @param [nil] イベント未登録の場合nil
    # @return [Hash] 筋トレ実施状況 { 二の腕: true, 腹筋: true, 裏腿: true, 脚: false  }
    def exercise_check_status(event)
        if event.nil? || event[:exercise].nil?
            Event::EXERCISE_PARTS.map { |part| [part, false] }.to_h
        else
            Event::EXERCISE_PARTS.map { |part| [part, event[:exercise].include?(part)] }.to_h
        end
    end

    # 筋トレ全て実施したか
    # @param [String] 実施した筋トレの配列
    # @param [nil] 全て未実施の場合nil
    # @return [Boolean] 全部実施 → true
    def is_exercise_complete(array)
        # arrayに配列が文字列で入ってきちゃう…
        # 変換しないといけないと思うが、ロジック的に判定は合うので一旦そのままにしてる
        if array.nil?
            false
        else
            Event::EXERCISE_PARTS.all? { |part| array.include?(part) }
        end
    end
end