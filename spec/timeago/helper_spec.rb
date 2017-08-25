# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rails::Timeago::Helper do
  before { @stub = TimeagoStub.new }
  let(:time) { Time.now }

  context '#timeago_tag' do
    let(:kwargs) { {} }
    subject { @stub.timeago_tag(time, **kwargs) }

    it 'creates a time tag' do
      is_expected.to match %r{<time.*>.*</time>}
    end

    it 'has a title attribute' do
      is_expected.to match %r{<time.*title=".*".*>.*</time>}
    end

    it 'has a human readable datetime as title attribute' do
      is_expected.to include "title=\"#{I18n.l time}\""
    end

    it 'has a data-time-ago attribute' do
      is_expected.to match %r{<time.*data-time-ago=".*".*>.*</time>}
    end

    context 'with nil as timestamp' do
      let(:time) { nil }
      it 'returns default string' do
        is_expected.to eq '-'
      end
    end

    describe 'format parameter' do
      let(:kwargs) { {format: format} }

      context 'with symbolic format' do
        let(:format) { :short }
        it { is_expected.to include "title=\"#{I18n.l time, format: :short}\"" }
      end

      context 'with proc format' do
        let(:format) { proc {|_time, _options| :long } }
        it { is_expected.to include "title=\"#{I18n.l time, format: :long}\"" }
      end
    end

    describe 'format global configuration' do
      before { Rails::Timeago.default_options format: format }

      context 'with symbolic format' do
        let(:format) { :short }
        it { is_expected.to include "title=\"#{I18n.l time, format: :short}\"" }
      end

      context 'with proc format' do
        let(:format) { proc {|_time, _options| :long } }
        it { is_expected.to include "title=\"#{I18n.l time, format: :long}\"" }
      end
    end

    describe 'title parameter' do
      let(:kwargs) { {title: title} }

      context 'with title disable' do
        let(:title) { false }
        it { is_expected.to_not match %r{<time.*title=".*".*>.*</time>} }
      end

      context 'with title set to nil' do
        let(:title) { nil }
        it { is_expected.to_not match %r{<time.*title=".*".*>.*</time>} }
      end

      context 'with title set to proc' do
        let(:title) { proc {|_, o| o[:format] } }
        let(:kwargs) { super().merge format: :short }
        it { is_expected.to match %r{<time.*title="short".*>.*</time>} }
      end
    end

    describe 'title global configuration' do
      before { Rails::Timeago.default_options title: title }

      context 'with title disabled' do
        let(:title) { false }
        it { is_expected.to_not match %r{<time.*title=".*".*>.*</time>} }
      end

      context 'with title set to nil' do
        let(:title) { nil }
        it { is_expected.to_not match %r{<time.*title=".*".*>.*</time>} }
      end

      context 'with title set to proc' do
        let(:title) { proc {|_, o| o[:format] } }
        let(:kwargs) { {format: :short} }
        it { is_expected.to match %r{<time.*title="short".*>.*</time>} }
      end
    end

    describe 'limit' do
      let(:time) { 5.days.ago }

      it 'should not have data-time-ago attribute for times before limit' do
        is_expected.to_not match %r{<time.*data-time-ago=".*".*>.*</time>}
      end

      context 'with given limit' do
        let(:kwargs) { {limit: limit} }

        context 'in past' do
          let(:limit) { 6.days.ago }

          context 'and past timestamp after limit' do
            let(:time) { 5.days.ago }
            it { is_expected.to match %r{<time.*data-time-ago=".*".*>.*</time>} }
          end

          context 'and past timestamp before limit' do
            let(:time) { 8.days.ago }
            it { is_expected.to_not match %r{<time.*data-time-ago=".*".*>.*</time>} }

            context 'when forced' do
              let(:kwargs) { super().merge force: true }
              it { is_expected.to match %r{<time.*data-time-ago=".*".*>.*</time>} }
            end
          end
        end

        context 'in future' do
          let(:limit) { 5.days.from_now }

          context 'and future timestamp after limit' do
            let(:time) { 7.days.from_now }
            it { is_expected.to_not match %r{<time.*data-time-ago=".*".*>.*</time>} }
          end

          context 'and future timestamp before limit' do
            let(:time) { 3.days.from_now }
            it { is_expected.to match %r{<time.*data-time-ago=".*".*>.*</time>} }
          end

          context 'and past timestamp' do
            let(:time) { 3.days.ago }
            it { is_expected.to_not match %r{<time.*data-time-ago=".*".*>.*</time>} }
          end
        end
      end
    end

    describe 'content' do
      let(:time) { 3.days.ago }

      it 'has localized date as content' do
        is_expected.to include ">#{I18n.l time.to_date}<"
      end

      context 'with :format option' do
        let(:kwargs) { {format: :short} }

        it 'has correctly formatted date as content' do
          is_expected.to include ">#{I18n.l time.to_date, format: :short}<"
        end
      end

      context 'with :date_only set to false' do
        let(:kwargs) { {date_only: false} }

        it 'has localized time as content' do
          is_expected.to include ">#{I18n.l time}<"
        end
      end
    end

    describe ':nojs set to true' do
      let(:time) { 3.days.ago }
      let(:kwargs) { {nojs: true} }

      it 'has time in words as content' do
        is_expected.to match %r{<time.*>%time_ago_in_words%</time>}
      end

      context 'with limit' do
        let(:kwargs) { super().merge limit: 2.days.ago }
        it { is_expected.to_not match %r{<time.*data-time-ago=".*".*>.*</time>} }
        it { is_expected.to include ">#{I18n.l time.to_date}<" }
      end
    end

    context 'with HTML options' do
      let(:kwargs) { {myattr: 'abc'} }

      it 'passes them to #tag_helper' do
        is_expected.to match %r{<time.*myattr="abc".*>.*<\/time>}
      end
    end
  end

  context '#timeago_script_tag' do
    subject { @stub.timeago_script_tag }

    it 'should return a javascript snippet to set jQuery timeago locale' do
      I18n.locale = 'en'
      is_expected.to eq '<script>jQuery.timeago.settings.lang="en";</script>'
    end
  end
end
