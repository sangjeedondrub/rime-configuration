-- single_char_first.lua
-- For very short inputs (1-2 syllables), prioritize single character candidates
-- and exact pinyin matches over abbreviated matches

local function get_char_count(text)
    local _, count = text:gsub("[%z\1-\127\194-\244][\128-\191]*", "")
    return count
end

local function filter(input, env)
    local context = env.engine.context
    local input_code = context.input

    -- Only apply for very short inputs (1-3 characters like "ni" "de" "shi")
    if #input_code > 3 then
        for cand in input:iter() do
            yield(cand)
        end
        return
    end

    -- Collect and categorize candidates
    local single_chars = {}
    local multi_chars = {}
    local all_candidates = {}

    for cand in input:iter() do
        table.insert(all_candidates, cand)
    end

    -- Separate single characters from multi-character words
    for _, cand in ipairs(all_candidates) do
        local char_count = get_char_count(cand.text)
        if char_count == 1 then
            table.insert(single_chars, cand)
        else
            table.insert(multi_chars, cand)
        end
    end

    -- For short inputs, yield single characters first
    for _, cand in ipairs(single_chars) do
        yield(cand)
    end

    -- Then multi-character words
    for _, cand in ipairs(multi_chars) do
        yield(cand)
    end
end

return filter
