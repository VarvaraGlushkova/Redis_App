class Post < ApplicationRecord
  has_rich_text :content  # для Markdown с ActionText (если нужен WYSIWYG)
  has_one_attached :cover_image

  validates :title, :published_at, presence: true
end
