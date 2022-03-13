module ListingsHelper
    def format_price(price)
        "$#{price/100}"    end
    def format_condition(condition)
        if condition == "brand_new"
            condition.gsub("_", " ").capitalize
        else
            condition.gsub("_", " - ").capitalize
        end
    end

    def display_photo(listing)
        if listing.photo.attached?
            image_tag listing.photo, alt: listing.title, class:"thumbnail card-img top"
        else
            image_tag "default_fridge", alt: "stock image of refridgerator", class:"thumbnail card-img top"
        end
    end
end