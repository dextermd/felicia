module ErrorHandling
  extend ActiveSupport::Concern

  included do
    # Обрабатывать ошибку которая называется  ActiveRecord::RecordNotFound
    # И обрабатывать ее следует в методе который называется notFound
    rescue_from ActiveRecord::RecordNotFound, with: :notFound

    private
    def notFound(exception)
      logger.warn exception
      render file: "public/404.html", status: :not_found, layout: false
    end

  end
end