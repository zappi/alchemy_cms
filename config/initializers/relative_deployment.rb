module ActionView
  module Helpers
    module AssetUrlHelper
      def remix_asset_path(source)
        raise ArgumentError, "nil is not a valid asset source" if source.nil?

        source = source.to_s
        return "" if source.blank?

        if defined?(config.relative_url_root) && config.relative_url_root.present?
          File.join(config.relative_url_root, source)
        else
          source
        end
      end
    end
  end
end
