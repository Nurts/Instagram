module PagesHelper
    def pretty_title(title)
        title.nil? ? "Instagram" : "Instagram | #{title}"
    end
end
