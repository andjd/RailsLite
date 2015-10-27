def unnest_key(key, value)
  split_key = key.delete("]").split "["
  master_key = split_key.shift
  sub_key = split_key.join("[")

  if sub_key.empty?
    return {master_key => value}
  else
    return {master_key => unnest_key(sub_key, value)}
  end
end

def deep_merge(master_hash, new_hash)
  p master_hash.to_s + new_hash.to_s
  merged_hash = {}
  master_hash.map do |m_key, m_val|
    if new_hash.keys.include?(m_key)
      n_val = new_hash[m_key]
      if n_val.is_a?(Hash) && m_val.is_a?(Hash)
        p "in if"
        deep_merge(m_val, n_val).merge(merged_hash) do |_, o, n|
          [o,n]
        end
      else
        p "in else"
        {m_key => [m_val, n_val]}.merge(merged_hash) do |_, o, n|
          [o,n]
        end
      end
    else
      merged_hash.merge({m_key => m_val})
    end
  end
  p "merged" + merged_hash.to_s
  new_hash.merge(merged_hash)

end
