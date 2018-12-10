/**
 * @author Dirk Gronert (dirk.gronert@salesforce.com)
 * @since  0.0.0
 * @fires  n/a
 */
({
    status : {s : 'SUCCESS', i : 'INCOMPLETE', e : 'ERROR'},
    
    /**
     * @author Dirk Gronert (dirk.gronert@salesforce.com)
     * @since  0.0.0
     * @param  {Aura.Component} cmp Component
     */
    validate : function(cmp) {
        let _aDoValidation = cmp.get('c.doValidation'),
            _vRecId = cmp.get('v.recordId'),
            _self = this,
            _$handleResponse = function(){
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({duration : 2000, type: 'success', message: 'Validation Successfull!'});
                toastEvent.fire();                
            },
            _$handleInclomplete = function(){_self.$handleIncomplete(cmp);},
            _$handleError = function(error){_self.$handleError(cmp, error);};
        _aDoValidation.setCallback(this, function(response){_$handleResponse(response.getReturnValue());}, _self.status.s);
        _aDoValidation.setCallback(this, function(response){_$handleInclomplete();}, _self.status.i);
        _aDoValidation.setCallback(this, function(response){_$handleError(response.getError());}, _self.status.e);

        _aDoValidation.setParams({requestId : _vRecId});
        $A.enqueueAction(_aDoValidation);
    },

    /**
     * @author Dirk Gronert (dirk.gronert@salesforce.com)
     * @since  0.0.0
     * @param  {Aura.Component} cmp Component
     */
    $handleIncomplete : function(cmp){
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({duration : 2000, type: 'error', message: 'Action incomplete!'});
        toastEvent.fire();
    },
    
    /**
     * @author Dirk Gronert (dirk.gronert@salesforce.com)
     * @since  0.0.0
     * @param  {Aura.Component} cmp Component
     * @param  String error Error
     */
    $handleError : function(cmp, error){
        console.log(error);
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({duration : 2000, type: 'error', message: error});
        toastEvent.fire();
    },


})