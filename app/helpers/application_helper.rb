module ApplicationHelper

    def assign_alert_class(flash_type)
        case flash_type
        when "notice"
            return "success"
        when "alert"
            return "warning"
        else
            return "info"
        end
    end

end