class PublishPostWorker
  include Sidekiq::Worker

  def perform(id)
    post = Post.find_by(id: id)
    post.publish! if post.present? && post.authenticated?
  end
end
