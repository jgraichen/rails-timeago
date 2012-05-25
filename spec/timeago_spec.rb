
require File.dirname(__FILE__) + '/spec_helper'

describe Rails::Timeago do
  context "#lookup_locale" do
    it "should return full locale if available" do
      Rails::Timeago.lookup_locale("zh-CN").should == "zh-CN"
    end

    it "should return formatted locale" do
      Rails::Timeago.lookup_locale("zh-cn").should == "zh-CN"
    end

    it "should return lang locale if available" do
      Rails::Timeago.lookup_locale("nl-NL").should == "nl"
    end

    it "should return locale if available" do
      Rails::Timeago.lookup_locale("de").should == "de"
    end

    it "should lookup default locale if nothing given" do
      I18n.locale = "ar"

      Rails::Timeago.lookup_locale.should == "ar"
    end

    it "should return english locale if locale does not
      match and default locale is not available" do

      I18n.locale = "sjn"
      Rails::Timeago.lookup_locale("tlh").should == "en"
    end

    context "with global locale configuration" do
      before { Rails::Timeago.locales = [:de, :en, "zh-CN", "tlh"] }
      after  { Rails::Timeago.locales = [] }

      it "should return full locale if available" do
        Rails::Timeago.lookup_locale("zh-CN").should == "zh-CN"
      end

      it "should return lang locale if available" do
        Rails::Timeago.lookup_locale("en-US").should == "en"
      end

      it "should return use default locale if available" do
        I18n.locale = "en"
        Rails::Timeago.lookup_locale.should == "en"
      end

      it "should return default locale for not specified locales" do
        I18n.locale = "ar"
        I18n.default_locale = :de
        Rails::Timeago.lookup_locale.should == "de"

        I18n.default_locale = :en
      end

      it "should find added locales that does not have a locale file in gem" do
        I18n.locale = "tlh"
        Rails::Timeago.lookup_locale.should == "tlh"
      end
    end
  end
end
