module ListingsHelper
    def format_price(price)
        "$#{price/100}"
    end
    def format_condition(condition)
        if condition == "brand_new"
            condition.gsub("_", " ").capitalize
        else
            condition.gsub("_", " - ").capitalize
        end
    end
end