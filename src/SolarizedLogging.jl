module SolarizedLogging
using Logging

function __init__()
    # Only modify console loggers
    cur_logger = global_logger()
    typeof(cur_logger) == Logging.ConsoleLogger || return

    new_logger = ConsoleLogger(cur_logger.stream, cur_logger.min_level;
        meta_formatter=solarized_metafmt, show_limited=cur_logger.show_limited,
        right_justify=cur_logger.right_justify)

    global_logger(new_logger)
end

function solarized_logcolor(level)
    level < Logging.Info  ? 4 :
    level < Logging.Warn  ? 6 :
    level < Logging.Error ? 3 :
                            1
end

function solarized_metafmt(level, _module, group, id, file, line)
    prefix_color = solarized_logcolor(level)
    prefix = (level == Logging.Warn ? "Warning" : string(level))*':'
    suffix_color = 10
    suffix = ""
    Logging.Info <= level < Logging.Warn && return prefix_color, prefix, suffix_color, suffix
    _module !== nothing && (suffix *= "$(_module)")
    if file !== nothing
        _module !== nothing && (suffix *= " ")
        suffix *= Base.contractuser(file)
        if line !== nothing
            suffix *= ":$(isa(line, UnitRange) ? "$(first(line))-$(last(line))" : line)"
        end
    end
    !isempty(suffix) && (suffix = "@ " * suffix)
    return prefix_color, prefix, suffix_color, suffix
end

end # module
