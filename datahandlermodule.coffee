datahandlermodule = {name: "datahandlermodule"}
############################################################
#region printLogFunctions
log = (arg) ->
    if allModules.debugmodule.modulesToDebug["datahandlermodule"]?  then console.log "[datahandlermodule]: " + arg
    return
ostr = (obj) -> JSON.stringify(obj, null, 4)
olog = (obj) -> log "\n" + ostr(obj)
print = (arg) -> console.log(arg)
#endregion

############################################################
#region dataMaps
assetPairToTickerInfo = {}
assetPairToBuyStack = {}
assetPairToSellStack = {}
assetToBalance = {}

#endregion

############################################################
datahandlermodule.initialize = () ->
    log "datahandlermodule.initialize"
    return

############################################################
#region internalFunctions
compareSells = (el1, el2) ->
    return el1.price - el2.price

compareBuys = (el1, el2) ->
    return el2.price - el1.price

#endregion
    
############################################################
#region exposedFunctions

############################################################
#region getterFunctions
datahandlermodule.setAssetBalance = (asset, balance) ->
    log "datahandlermodule.setAssetBalance"
    assetToBalance[asset] = balance
    return

datahandlermodule.setSellStack = (pair, sellStack) ->
    log "datahandlermodule.setSellStack"
    sellStack.sort(compareSells)
    assetPairToSellStack[pair] = sellStack
    return

datahandlermodule.setBuyStack = (pair, buyStack) ->
    log "datahandlermodule.setBuyStack"
    buyStack.sort(compareBuys)
    assetPairToBuyStack[pair] = buyStack
    return

datahandlermodule.setTicker = (pair, ticker) ->
    log "datahandlermodule.setTicker"
    assetPairToTickerInfo[pair] = ticker
    return

#endregion

############################################################
#region getterFunctions
datahandlermodule.getAssetBalance = (asset) ->
    log "datahandlermodule.getAssetBalance"
    return assetToBalance[asset]

datahandlermodule.getSellStack = (pair) ->
    log "datahandlermodule.getSellStack"
    return assetPairToSellStack[pair]

datahandlermodule.getBuyStack = (pair) ->
    log "datahandlermodule.getBuyStack"
    return assetPairToBuyStack[pair]

datahandlermodule.getTicker = (pair) ->
    log "datahandlermodule.getTicker"
    return assetPairToTickerInfo[pair]

#endregion

#endregion

module.exports = datahandlermodule