module ListingsHelper
    def format_price(price)
        "$#{price/100}"
    end
    def format_condition(condition)
        condition.gsub("_", " - ").capitalize
    end
end