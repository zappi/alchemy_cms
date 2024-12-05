# WARNING: this code may need to be changed depending on Rails version

module ActionView
  module Helpers
    module AssetUrlHelper
      def remix_asset_path(source, options={})
        raise ArgumentError, "nil is not a valid asset source" if source.nil?

        source = source.to_s
        return "" if source.blank?
        return source if URI_REGEXP.match?(source)

        tail = source[/([?#].+)$/]
        source = source.sub(/([?#].+)$/, "")

        if extname = compute_asset_extname(source, options)
          source = "#{source}#{extname}"
        end

        if source[0] != ?/
          if options[:skip_pipeline]
            source = public_compute_asset_path(source, options)
          else
            source = compute_asset_path(source, options)
          end
        end

        if !defined?(config.asset_host) || config.asset_host.blank? # Added if
          relative_url_root = defined?(config.relative_url_root) && config.relative_url_root
          if relative_url_root
            source = File.join(relative_url_root, source) unless source.start_with?("#{relative_url_root}/")
          end
        end

        if host = compute_asset_host(source, options)
          source = File.join(host, source)
        end

        "#{source}#{tail}"
      end
      alias_method :path_to_remix_asset, :remix_asset_path
    end
  end
end
