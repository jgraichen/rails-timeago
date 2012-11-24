class TimeagoStub
  include Rails::Timeago::Helper

  I18n.backend.store_translations :en, :hello => 'World'

  def time_tag(time, content, options = {})
    options = options.map { |k,v| "#{k}=\"#{v}\""}
    "<time datetime=\"#{time.iso8601}\" #{options.join ' '}>#{content}</time>"
  end

  def time_ago_in_words(time)
    "%time_ago_in_words%"
  end

  def javascript_tag(source)
    "<script>#{source}</script>"
  end
end
