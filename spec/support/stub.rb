# frozen_string_literal: true

class TimeagoStub
  include Rails::Timeago::Helper

  I18n.backend.store_translations :en, hello: 'World'

  def time_tag(time, content, options = {})
    options = options.map {|k, v| "#{k}=\"#{v}\"" }
    "<time datetime=\"#{time.iso8601}\" #{options.join ' '}>#{content}</time>"
  end

  def time_ago_in_words(_time)
    '%time_ago_in_words%'
  end

  def javascript_tag(source)
    "<script>#{source}</script>"
  end
end

class Application
  attr_accessor :render

  ASSET_BASE = Pathname.new(File.expand_path('../../..', __FILE__))
  ASSET_DIRECTORIES = %w[lib/assets vendor/assets spec/support/assets].freeze

  def initialize
    @helper = TimeagoStub.new
  end

  def call(env)
    @request = ::Rack::Request.new(env)

    if @request.path =~ %r{^/assets/}
      call_asset
    else
      [200, {'Content-Type' => 'text/html'}, [call_render]]
    end
  end

  def call_render
    body = if @render
             @render.call(@helper, @request)
           else
             '<noscript></noscript>'
           end

    <<-HTML
      <html>
        <head>
          <title></title>
          <script src="/assets/javascripts/jquery.js"></script>
          <script src="/assets/javascripts/jquery.timeago.js"></script>
          <script src="/assets/javascripts/locales/jquery.timeago.de.js"></script>
          <script src="/assets/javascripts/rails-timeago.js"></script>
          #{@helper.timeago_script_tag}
        </head>
        <body>
          #{body}
        </body>
      </html>
    HTML
  end

  def call_asset
    if (file = find_asset(@request.path[8..-1]))
      [200, {'Content-Type' => 'text/javascript'}, [file.read]]
    else
      [404, {}, []]
    end
  end

  def find_asset(path)
    ASSET_DIRECTORIES.lazy.map do |dir|
      ASSET_BASE.join(dir).join(path)
    end.find(&:exist?)
  end

  class << self
    def instance
      @instance ||= new
    end

    def render(&block)
      @instance.render = block
    end
  end
end
