-- wanxiang_tagger.lua
-- Adds 〔万象〕 tag to candidates from wanxiang_supplement translator

local function filter(input)
    for cand in input:iter() do
        -- Get the quality which we set to 0.7 for wanxiang_supplement
        -- Candidates from wanxiang_supplement have initial_quality: 0.7
        local quality = cand.quality

        if quality and math.abs(quality - 0.7) < 0.01 then
            -- This is likely from wanxiang_supplement (quality = 0.7)
            local comment = cand.comment or ""
            cand:get_genuine().comment = "〔万象〕" .. comment
        end

        yield(cand)
    end
end

return filter
