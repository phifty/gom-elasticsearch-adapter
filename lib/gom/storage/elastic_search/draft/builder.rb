
# Builds a draft out of a search result item document.
class GOM::Storage::ElasticSearch::Draft::Builder

  def initialize(item)
    @item = hashed item
  end

  def draft
    initialize_draft
    set_object_id
    set_class
    set_properties_and_relations
    @draft
  end

  private

  def hashed(item)
    return item unless item.is_a?(Tire::Results::Item)
    hash = item.to_hash
    hash.each do |key, value|
      hash[key] = value.is_a?(Array) ? value.map{ |entry| hashed entry } : hashed(value)
    end
    hash
  end

  def initialize_draft
    @draft = GOM::Object::Draft.new
  end

  def set_object_id
    @draft.object_id = @item[:_id]
  end

  def set_class
    @draft.class_name = @item[:model_class]
  end

  def set_properties_and_relations
    @item.each do |key, value|
      set_property key.to_s, value if property_key?(key)
      set_relation key.to_s, value if relation_key?(key)
    end
  end

  def set_property(key, value)
    @draft.properties[key.to_sym] = value
  end

  def set_relation(key, value)
    name = key.sub /_id$/, ""
    id = GOM::Object::Id.new value
    @draft.relations[name.to_sym] = GOM::Object::Proxy.new id
  end

  def property_key?(key)
    !relation_key?(key) && ![ "_id", "_rev", "model_class" ].include?(key)
  end

  def relation_key?(key)
    !!(key =~ /.+_id$/)
  end

end
