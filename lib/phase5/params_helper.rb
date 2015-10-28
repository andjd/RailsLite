require "byebug"
def unnest_key(key, value)
  split_key = key.delete("]").split("[")
  master_key = split_key.shift
  sub_key = split_key.join("[")

  if sub_key.empty?
    return {master_key => value}
  else
    return {master_key => unnest_key(sub_key, value)}
  end
end

def deep_merge(master_hash, new_hash)
  merged_hash = {}

  new_master_hash = master_hash.reduce({}) do |out, tuple|
    m_key, m_val = tuple
    sub_hash = deep_merge_helper(m_key, m_val, new_hash, merged_hash)
    out.merge sub_hash
  end

  clean_new_hash = new_hash.reject do |k, _|
    new_master_hash.all_keys.include?(k)
  end

  new_master_hash.merge(clean_new_hash)

end

def deep_merge_helper(m_key, m_val, new_hash, merged_hash)

  if new_hash.keys.include?(m_key)
    n_val = new_hash[m_key]

    #recursive case
    if n_val.is_a?(Hash) && m_val.is_a?(Hash)
      return ({m_key => deep_merge(m_val, n_val)}).merge(merged_hash) do |_, o, n|
        [o,n]
      end

      #base case
    else
      return {m_key => [m_val, n_val]}.merge(merged_hash) do |_, o, n|
        [o,n]
      end

    end

  else

    #edge case (should not occur)
    if new_hash.keys.include?(m_val)
      n_val = new_hash[m_val]
      return merged_hash.merge({m_key => {m_val => n_val}})

    #secondary edge case elsif new_hash.values.include?(m_key)
    #should not occur

    #alternate base case
    else
      return merged_hash.merge({m_key => m_val})

    end
  end
end


class Hash
  def all_keys
    out = []
    self.each do |k, v|
      out += [k]

      if v.is_a?(Hash)
        out += v.all_keys
      end
    end
    out
  end
end
