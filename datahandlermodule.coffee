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
assetPairToTickerInfoReady = {}

assetPairToBuyStack = {}
assetPairToBuyStackReady = {}

assetPairToSellStack = {}
assetPairToSellStackReady = {}

assetPairToCancelledStack = {}
assetPairToCancelledStackReady = {}

assetPairToFilledStack = {}
assetPairToFilledStackReady = {}

assetToBalance = {}
assetToBalanceReady = {}


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
#region setterFunctions
datahandlermodule.setAssetBalance = (asset, balance) ->
    log "datahandlermodule.setAssetBalance"
    assetToBalance[asset] = balance
    assetToBalanceReady[asset] = true
    print "set asset to ready: " + asset
    return

datahandlermodule.setCancelledStack = (pair, cancelledStack) ->
    log "datahandlermodule.setCancelledStack"
    cancelledStack.sort(compareOldOrders)
    if cancelledStack.length > cancelFillStackHeight then cancelledStack.length = cancelFillStackHeight
    assetPairToCancelledStack[pair] = cancelledStack
    assetPairToCancelledStackReady[pair] = true
    return

datahandlermodule.setFilledStack = (pair, filledStack) ->
    log "datahandlermodule.setFilledStack"
    filledStack.sort(compareOldOrders)
    if filledStack.length > cancelFillStackHeight then filledStack.length = cancelFillStackHeight
    assetPairToFilledStack[pair] = filledStack
    assetPairToFilledStackReady[pair] = true
    return


datahandlermodule.setSellStack = (pair, sellStack) ->
    log "datahandlermodule.setSellStack"
    sellStack.sort(compareSells)
    assetPairToSellStack[pair] = sellStack
    assetPairToSellStackReady[pair] = true
    return

datahandlermodule.setBuyStack = (pair, buyStack) ->
    log "datahandlermodule.setBuyStack"
    buyStack.sort(compareBuys)
    assetPairToBuyStack[pair] = buyStack
    assetPairToBuyStackReady[pair] = true
    return

datahandlermodule.setTicker = (pair, ticker) ->
    log "datahandlermodule.setTicker"
    assetPairToTickerInfo[pair] = ticker
    assetPairToTickerInfoReady[pair] = true
    return

#endregion

############################################################
#region getterFunctions
datahandlermodule.getAssetBalance = (asset) ->
    log "datahandlermodule.getAssetBalance"
    throw new Error("Balance not ready!") unless assetToBalanceReady[asset]
    return assetToBalance[asset]

datahandlermodule.getFilledStack = (pair) ->
    log "datahandlermodule.getFilledStack"
    throw new Error("FilledStack not ready!") unless assetPairToFilledStackReady[pair]
    return assetPairToFilledStack[pair]

datahandlermodule.getCancelledStack = (pair) ->
    log "datahandlermodule.getCancelledStack"
    throw new Error("CancelledStack not ready!") unless assetPairToCancelledStackReady[pair]
    return assetPairToCancelledStack[pair]

datahandlermodule.getSellStack = (pair) ->
    log "datahandlermodule.getSellStack"
    throw new Error("SellStack not ready!") unless assetPairToSellStackReady[pair]
    return assetPairToSellStack[pair]

datahandlermodule.getBuyStack = (pair) ->
    log "datahandlermodule.getBuyStack"
    throw new Error("BuyStack not ready!") unless assetPairToBuyStackReady[pair]
    return assetPairToBuyStack[pair]

datahandlermodule.getTicker = (pair) ->
    log "datahandlermodule.getTicker"
    throw new Error("Ticker not ready!") unless assetPairToTickerInfoReady[pair]
    return assetPairToTickerInfo[pair]

#endregion

#endregion

module.exports = datahandlermodule