json.error false
json.prices @prices do |price| 
    json.merge! price.attributes.except("priceable_id","priceable_type")
end