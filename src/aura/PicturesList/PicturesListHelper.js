({
    setImages : function(component) {
        var action = component.get("c.getAllImages");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if ( state === 'SUCCESS' && component.isValid() ) {
                component.set("v.pictures", response.getReturnValue());
                component.set("v.isFilteredData", false);
                
                var pageSize = component.get("v.pageSize");
                component.set("v.totalRecords", component.get("v.pictures").length);
                component.set("v.startPage", 0);                
                component.set("v.endPage", pageSize - 1);
                var PagList = [];
                for ( var i=0; i< pageSize; i++ ) {
                    if ( component.get("v.pictures").length> i )
                        console.log(response.getReturnValue()[i]);
                    PagList.push(response.getReturnValue()[i]);    
                }
                component.set('v.paginationList', PagList);
            }else {
                alert('ERROR');
            }
            
        });
        $A.enqueueAction(action);
        
    },
    setFilteredImages : function(component) {
        console.log('******');
        var action = component.get("c.getFilteredImages");
        var filter = document.getElementById('titleInput').value;
        action.setParams({  namefilter : filter  });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if ( state === 'SUCCESS' && component.isValid() ) {
                component.set("v.pictures", response.getReturnValue());
                component.set("v.isFilteredData", true);
                
                var pageSize = component.get("v.pageSize");
                console.log('pageSize'+pageSize);
                component.set("v.totalRecords", component.get("v.pictures").length);
                component.set("v.startPage", 0);                
                component.set("v.endPage", pageSize - 1);
                console.log('-------');
                var PagList = [];
                console.log('component.get("v.pictures").length'+component.get("v.pictures").length);
                console.log('pageSize'+pageSize);
                if(pageSize>component.get("v.pictures").length){
                    pageSize = component.get("v.pictures").length;
                    component.set("v.pageSize", pageSize);
                }else{
                    pageSize = 9;
                    component.set("v.pageSize", pageSize);
                }
                for ( var i=0; i< pageSize; i++ ) {
                    if ( component.get("v.pictures").length> i )
                        console.log(response.getReturnValue()[i]);
                    PagList.push(response.getReturnValue()[i]);    
                }
                component.set('v.paginationList', PagList);
            }else{
                alert('ERROR');
            }
        });
        $A.enqueueAction(action);
    },
    sendEmailResults : function(component) {
        var action = component.get("c.sendEmailWithResults");
        var results = JSON.stringify(component.get("v.pictures"));
        action.setParams({  messageBody : results  });
        action.setCallback(this, function(response) {
        });
        $A.enqueueAction(action);
    },
    nextPage : function(component) {
        var sObjectList = component.get("v.pictures");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var PagList = [];
        var counter = 0;
        for ( var i = end + 1; i < end + pageSize + 1; i++ ) {
            if ( sObjectList.length > i ) {
                PagList.push(sObjectList[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        component.set("v.startPage", start);
        component.set("v.endPage", end);
        component.set('v.paginationList', PagList);
    },
    previousPage : function(component) {
        
        var sObjectList = component.get("v.pictures");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var PagList = [];
        var counter = 0;
        for ( var i= start-pageSize; i < start ; i++ ) {
            if ( i > -1 ) {
                PagList.push(sObjectList[i]);
                counter ++;
            } else {
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.startPage", start);
        component.set("v.endPage", end);
        component.set('v.paginationList', PagList);
    }
    
})