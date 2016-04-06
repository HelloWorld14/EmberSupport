ApplicationName.ApplicationAdapter = DS.ActiveModelAdapter.extend({

  ajaxOptions: (url, type, hash) ->
    hash = hash || {}
    hash.url = url
    hash.type = type
    hash.dataType = 'json'
    hash.context = @

    if hash.data and type != 'GET' and type != 'DELETE'
      hash.processData = false
      hash.contentType = false
      fd = new FormData()
      root = Object.keys(hash.data)[0]
      for key in Object.keys(hash.data[root])
        if hash.data[root][key]
          fd.append("#{root}[#{key}]", hash.data[root][key])

      hash.data = fd

    headers = @get('headers')
    if headers != undefined
      hash.beforeSend = (xhr) ->
        for key in Ember.keys(headers)
          xhr.setRequestHeader(key, headers[key])

    hash

})