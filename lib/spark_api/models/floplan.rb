module SparkApi
  module Models
    class FloPlan < Base
      extend Subresource
      self.element_name = 'floplans'

      attr_accessor :images, :thumbnails

      def initialize(attributes={})
        @images = []
        @thumbnails = []
        unless attributes['Images'].nil?
          attributes['Images'].each do |img|
            if img["Type"].include?('thumbnail')
              @thumbnails << img
            else
              @images << img
            end
          end
        end
        super(attributes)
      end
    end
  end
end
