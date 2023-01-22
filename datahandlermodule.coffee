############################################################
#region debug
import { createLogFunctions } from "thingy-debug"
{log, olog} = createLogFunctions("datahandlermodule")
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
export initialize = () ->
    log "initialize"
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
export setAssetBalance = (asset, balance) ->
    log "setAssetBalance"
    assetToBalance[asset] = balance
    assetToBalanceReady[asset] = true
    return

export setCancelledStack = (pair, cancelledStack) ->
    log "setCancelledStack"
    cancelledStack.sort(compareOldOrders)
    if cancelledStack.length > cancelFillStackHeight then cancelledStack.length = cancelFillStackHeight
    assetPairToCancelledStack[pair] = cancelledStack
    assetPairToCancelledStackReady[pair] = true
    return

export setFilledStack = (pair, filledStack) ->
    log "setFilledStack"
    filledStack.sort(compareOldOrders)
    if filledStack.length > cancelFillStackHeight then filledStack.length = cancelFillStackHeight
    assetPairToFilledStack[pair] = filledStack
    assetPairToFilledStackReady[pair] = true
    return


export setSellStack = (pair, sellStack) ->
    log "setSellStack"
    sellStack.sort(compareSells)
    assetPairToSellStack[pair] = sellStack
    assetPairToSellStackReady[pair] = true
    return

export setBuyStack = (pair, buyStack) ->
    log "setBuyStack"
    buyStack.sort(compareBuys)
    assetPairToBuyStack[pair] = buyStack
    assetPairToBuyStackReady[pair] = true
    return

export setTicker = (pair, ticker) ->
    log "setTicker"
    assetPairToTickerInfo[pair] = ticker
    assetPairToTickerInfoReady[pair] = true
    return

#endregion

############################################################
#region getterFunctions
export getAssetBalance = (asset) ->
    log "getAssetBalance"
    throw new Error("Balance not ready!") unless assetToBalanceReady[asset]
    return assetToBalance[asset]

export getFilledStack = (pair) ->
    log "getFilledStack"
    throw new Error("FilledStack not ready!") unless assetPairToFilledStackReady[pair]
    return assetPairToFilledStack[pair]

export getCancelledStack = (pair) ->
    log "getCancelledStack"
    throw new Error("CancelledStack not ready!") unless assetPairToCancelledStackReady[pair]
    return assetPairToCancelledStack[pair]

export getSellStack = (pair) ->
    log "getSellStack"
    throw new Error("SellStack not ready!") unless assetPairToSellStackReady[pair]
    return assetPairToSellStack[pair]

export getBuyStack = (pair) ->
    log "getBuyStack"
    throw new Error("BuyStack not ready!") unless assetPairToBuyStackReady[pair]
    return assetPairToBuyStack[pair]

export getTicker = (pair) ->
    log "getTicker"
    throw new Error("Ticker not ready!") unless assetPairToTickerInfoReady[pair]
    return assetPairToTickerInfo[pair]

#endregion

#endregion
