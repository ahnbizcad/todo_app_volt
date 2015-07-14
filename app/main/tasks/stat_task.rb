class StatTask < Volt::Task

    def show_stats
        {
            version: RUBY_VERSION,
            description: RUBY_DESCRIPTION,
            platform: RUBY_PLATFORM
        }   # hash in this context will be coerced into a volt model when it reaches the frontend
    end

end
