({
    onClick : function(cmp, evt, hlp) {
        var id = evt.target.dataset.menuItemId;
        if(id) cmp.getSuper().navigate(id);
   }
})