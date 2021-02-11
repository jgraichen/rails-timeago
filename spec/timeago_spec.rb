# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'rails-timeago', type: :feature, js: true do
  let(:time) { 2.days.ago }

  before do
    Application.render do |args|
      Time.zone = 'UTC'
      render.call(*args)
    end
  end

  before { visit '/' }
  subject { find 'body > time' }

  describe 'renders simple timeago tag' do
    let(:render) do
      ->(h) { h.timeago_tag(time) }
    end

    it { is_expected.to have_content '2 days ago' }
    it { expect(subject[:lang]).to eq '' }
    it { expect(subject[:title]).to eq I18n.l(time) }
    it { expect(subject[:datetime]).to eq time.iso8601 }
  end

  describe 'renders timeago tag with language' do
    let(:render) do
      ->(h) { h.timeago_tag(time, lang: :de) }
    end

    it { is_expected.to have_content 'vor 2 Tagen' }
    it { expect(subject[:lang]).to eq 'de' }
    it { expect(subject[:title]).to eq I18n.l(time) }
  end

  describe 'renders timeago tag with format' do
    let(:render) do
      ->(h) { h.timeago_tag(time, format: :short) }
    end

    it { expect(subject[:title]).to eq I18n.l(time, format: :short) }
  end
end
