module Tutorials
  module Outline
    extend self

    def clean(content)
      cleaners.inject(content) do |content,cleaner|
        send(cleaner,content)
      end
    end

    def cleaners
      [ :strip_yaml_front_matter, :replace_page_url_liquid_tag_with_full_url ]
    end

    private

    def strip_yaml_front_matter(content)
      content.gsub(/\A---\s*\n(.+\n)*^---\s*\n/,'')
    end

    def replace_page_url_liquid_tag_with_full_url(content)
      content.gsub(/\{% page_url (.+) %\}/,"#{tutorial_website}/$1")
    end

    def tutorial_website
      "http://tutorials.jumpstartlab.com"
    end

  end
end