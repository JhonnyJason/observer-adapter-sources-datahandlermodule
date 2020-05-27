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
assetPairToCancelledStack = {}
assetPairToFilledStack = {}
assetToBalance = {}

#endregion

############################################################
cancelFillStackHeight = 0

############################################################
datahandlermodule.initialize = () ->
    log "datahandlermodule.initialize"
    cancelFillStackHeight = allModules.configmodule.cancelFillStackHeight
    return

############################################################
#region internalFunctions
compareSells = (el1, el2) ->
    return el1.price - el2.price

compareBuys = (el1, el2) ->
    return el2.price - el1.price

compareOldOrders = (el1, el2) ->
    return el2.time - el1.time

#endregion
    
############################################################
#region exposedFunctions

############################################################
#region getterFunctions
datahandlermodule.setAssetBalance = (asset, balance) ->
    log "datahandlermodule.setAssetBalance"
    assetToBalance[asset] = balance
    return

datahandlermodule.setCancelledStack = (pair, cancelledStack) ->
    log "datahandlermodule.setCancelledStack"
    cancelledStack.sort(compareOldOrders)
    if cancelledStack.length > cancelFillStackHeight then cancelledStack.length = cancelFillStackHeight
    assetPairToCancelledStack[pair] = cancelledStack
    return

datahandlermodule.setFilledStack = (pair, filledStack) ->
    log "datahandlermodule.setFilledStack"
    filledStack.sort(compareOldOrders)
    if filledStack.length > cancelFillStackHeight then filledStack.length = cancelFillStackHeight
    assetPairToFilledStack[pair] = filledStack
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

datahandlermodule.getFilledStack = (pair) ->
    log "datahandlermodule.getFilledStack"
    return assetPairToFilledStack[pair]

datahandlermodule.getCancelledStack = (pair) ->
    log "datahandlermodule.getCancelledStack"
    return assetPairToCancelledStack[pair]

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