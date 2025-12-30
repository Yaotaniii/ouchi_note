class ActivityLog < ApplicationRecord
  belongs_to :user

  validates :action, presence: true

  # 最新順で取得
  default_scope { order(created_at: :desc) }

  # アクション種別の日本語表示
  def action_label
    case action
    when 'create' then '登録'
    when 'update' then '更新'
    when 'destroy' then '削除'
    else action
    end
  end
end