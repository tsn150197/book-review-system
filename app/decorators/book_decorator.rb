class BookDecorator < Draper::Decorator
  delegate_all

  def self.collection_decorator_class
    PaginatingDecorator
  end

  def average_reviews
    return 0 if object.reviews.blank?
    object.reviews.average(:rate).round Settings.average_rate
  end

  def count_reviews
    object.reviews.length
  end

  def review_of_current_user?
    return false if h.current_user && object.reviews
                                            .where(user: h.current_user).blank?
    true
  end

  def cover_image_asset
    helpers.asset_path helpers.check_image_cover(object)
  end
end
