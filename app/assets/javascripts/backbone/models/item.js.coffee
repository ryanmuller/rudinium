class Rudini.Models.Item extends Backbone.Model
  paramRoot: 'item'

  defaults:
    name: null
    content: null
    label: null
    video_id: null
    video_time: null
    video_end: null
    item_info: null
    lecture_id: null
    id: null


  # returns the memory object associated with this item.
  # if no associated memory, returnes undefined
  memory: () ->
    return undefined if ! RudiniApp.studying
    item_id = @attributes.id
    console.log(item_id)
    RudiniApp.studying.find((model) ->
      return model.get("item_id") == item_id )



class Rudini.Collections.ItemsCollection extends Backbone.Collection
  model: Rudini.Models.Item
  url: '/items'

  # search function for ItemsCollection
  # returns wrapper of matched items
  search: (query, label = null) ->

    # if empty query, return all items
    if query == ""
      return _(this.filter((data) ->
        return true ))

    # else, check for labels or return items containing query
    pattern = new RegExp(query, 'gi')
    switch (label)
      when "rudin" 
        return _(this.filter((data) ->
          return query == data.get("item_info")['rudin_eq']))
      when "chapter"
        return _(this.filter((data) ->
          return query == data.get("item_info")['rudin_ch']))
      when "lecture"
        return _(this.filter((data) ->
          return query == data.get("item_info")['lecture_id']))
      when "section"
        return _(this.filter((data) ->
          return pattern.test(data.get("item_info")['rudin_section'])))
      else
        return _(this.filter((data) ->
          return pattern.test(data.get("content")) || pattern.test(data.get("name"))))

