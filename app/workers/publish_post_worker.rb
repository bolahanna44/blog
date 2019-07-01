class PublishPostWorker
  include Sidekiq::Worker

  def perform(id)
    post = Post.find(id)
    post.publish! if post.present?
  end
end
