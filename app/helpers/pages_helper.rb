module PagesHelper
    def pretty_title(title)
        "Instagram" + (title.nil? ? "": " | #{title}")
    end
end
