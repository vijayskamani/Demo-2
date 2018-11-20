
function compare(baseDivId, targetDivId) 
{
	console.log('baseDivId--'+baseDivId);
	console.log('targetDivId--'+targetDivId);
    var source_fileName = $("[id$='source_fileName']").val();
    var target_fileName = $("[id$='target_fileName']").val();
    
    var source_fullname = $("[id$='source_fullname']").val();
    var target_fullname = $("[id$='target_fullname']").val();
    
    console.log('source_fullname--'+source_fullname);
	console.log('target_fullname--'+target_fullname);
    
    var source_parentName = $("[id$='source_parentName']").val();
    var target_parentName = $("[id$='target_parentName']").val();
    
    console.log('source_parentName--'+source_parentName);
	console.log('target_parentName--'+target_parentName);
    
    var source_version = $("[id$='source_version']").val();
    var target_version = $("[id$='target_version']").val();
    
    var source_contentId = $("[id$='source_contentId']").val();
    var target_contentId = $("[id$='target_contentId']").val();
    
    var source_parentId = $("[id$='source_parentId']").val();
    var target_parentId = $("[id$='target_parentId']").val();
    
    var componentType = $("[id$='componentType']").val();
    console.log(componentType);
    if(componentType != undefined && componentType != '')
    {
    	var tempType = folderMap[componentType] != undefined ? folderMap[componentType] : componentType;
    	console.log('source_parentId+#+componentType+#+source_fileName--'+source_parentId+'#'+componentType+'#'+source_fileName);
    	console.log(detailDataMap);
    	var sourceComponentFileMap = {};
    	var targetComponentFileMap = {};
        if(detailDataMap[source_parentId+'#'+componentType+'#'+source_fileName] != undefined )
        {
        	var fullXml = detailDataMap[source_parentId+'#'+componentType+'#'+source_fileName];
        	if(childMap[componentType] != undefined)
	        {
	        	var childDataMap = childSplitter(fullXml,componentType,source_fileName);
	        	if(childDataMap[componentType+'#'+source_fullname] != undefined )
	            {
        			sourceComponentFileMap[source_fullname] = childDataMap[componentType+'#'+source_fullname];
	            	//document.getElementById('baseText').value = childDataMap[componentType+'#'+source_fullname];
	            }
	        }
	        else{
	        	sourceComponentFileMap[source_fileName] = fullXml;
	        	if(detailDataMap[source_parentId+'#'+componentType+'#'+source_fileName+'-meta.xml'] != undefined)
	    		{
	        		sourceComponentFileMap[source_fileName+'-meta.xml'] = detailDataMap[source_parentId+'#'+componentType+'#'+source_fileName+'-meta.xml'];
	    		}
	        	//document.getElementById('baseText').value = fullXml;
	        	
	        }
	    }
        else if(detailDataMap[source_parentId+'#'+tempType+'#'+source_fileName] != undefined )
        {
        	var fullXml = detailDataMap[source_parentId+'#'+tempType+'#'+source_fileName];
        	sourceComponentFileMap[source_fileName] = fullXml;
        	//document.getElementById('baseText').value = fullXml;
        }
        else if(tempType == 'AuraDefinitionBundle')
    	{
        	for(var fileName in detailDataMap)
    		{
        		if(fileName != undefined && fileName.indexOf(source_parentId+'#'+componentType+'#'+source_fileName+'/') == 0)
    			{
    				var tempFileName = fileName.split(source_parentId+'#'+tempType+'#')[1];
        			sourceComponentFileMap[tempFileName] = detailDataMap[fileName];
    			}
    		}
    	}
        if(detailDataMap[target_parentId+'#'+componentType+'#'+target_fileName] != undefined )
        {
        	var fullXml = detailDataMap[target_parentId+'#'+componentType+'#'+target_fileName];
        	if(childMap[componentType] != undefined)
	        {
	        	var childDataMap = childSplitter(fullXml,componentType,target_fileName);
	        	if(childDataMap[componentType+'#'+target_fullname] != undefined )
	            {
	        		targetComponentFileMap[target_fullname] = childDataMap[componentType+'#'+target_fullname];
	            	//document.getElementById('newText').value = childDataMap[componentType+'#'+target_fullname];
	            }
	            
	        }
	        else{
	        	targetComponentFileMap[target_fileName] = fullXml;
	        	if(detailDataMap[target_parentId+'#'+componentType+'#'+target_fileName+'-meta.xml'] != undefined)
	    		{
	        		targetComponentFileMap[target_fileName+'-meta.xml'] = detailDataMap[target_parentId+'#'+componentType+'#'+target_fileName+'-meta.xml'];
	    		}
	        	//document.getElementById('newText').value = fullXml;
	        }
	        	
        }
        else if(detailDataMap[target_parentId+'#'+tempType+'#'+target_fileName] != undefined )
        {
        	var fullXml = detailDataMap[target_parentId+'#'+tempType+'#'+target_fileName];
        	sourceComponentFileMap[target_fileName] = fullXml;
        	//document.getElementById('newText').value = fullXml;
        }
        else if(tempType == 'AuraDefinitionBundle')
    	{
        	for(var targetfileName in detailDataMap)
    		{
        		if(targetfileName != undefined && targetfileName.indexOf(target_parentId+'#'+componentType+'#'+target_fileName+'/') == 0)
    			{
    				var tempFileName = targetfileName.split(target_parentId+'#'+tempType+'#')[1];
        			targetComponentFileMap[tempFileName] = detailDataMap[targetfileName];
    			}
    		}
    	}
        
    	var index = 1;
    	var contentBase = document.getElementById(baseDivId);
    	var viewBase = document.getElementById(targetDivId);
    	
    	contentBase.innerHTML = '';
    	
    	var itemName = $('#itemName').html();
        var s1 = ''+source_parentName;
        var s2 = ''+target_parentName;
        //if newtxt or baseText is empty then add 'Not Exist'
        if(isEmpty(sourceComponentFileMap)/*document.getElementById('baseText').value.trim() == ''*/)
            s1 += ' : Not Exist';
        else
        {
        	if(source_version != undefined && source_version != '' && source_version != null)
    			s1 += ' : ' + source_fullname + ' (Version: ' + source_version + ')';
   			else
   				s1 += ' : ' + source_fullname;
   		}
        if(isEmpty(targetComponentFileMap)/*document.getElementById('newText').value.trim() == ''*/)
            s2 += ' : Not Exist';
        else
        {
        	if(target_version != undefined && target_version != '' && target_version != null)
    			s2 += ' : ' + target_fullname + ' (Version: ' + target_version + ')';
   			else
        		s2 += ' : ' + target_fullname;
    	}
    	console.log('s1 ####  ' + s1);
    	console.log('s2 ####  ' + s2);
    	viewBase.innerHTML = '<div style="display: flex;"><div style="width: 50%;"><h4>'+s1+'</h4></div><div style="width: 50%;"><h4>'+s2+'</h4></div></div>';

    	/*var sourcePara = document.createElement("p");
		var sourceNode = document.createTextNode(source_parentName+'('+source_fullname+')');
		sourcePara.appendChild(sourceNode);
		document.getElementById("targetDivToShowComparison").appendChild(sourcePara);
    	
    	var targetPara = document.createElement("p");
		var targetNode = document.createTextNode(target_parentName+'('+target_fullname+')');
		targetPara.appendChild(targetNode);
		document.getElementById("targetDivToShowComparison").appendChild(targetPara);*/

    	
    	for(var fileName in sourceComponentFileMap)
		{
    		var baseTextId = 'baseText'+index;
    		var newTextId = 'newText'+index;
    		var viewDivId = 'diffoutput'+index;
    		
    		
    		var x = document.createElement("TEXTAREA");
    		x.setAttribute('id',baseTextId);
    		x.value = sourceComponentFileMap[fileName];
    		x.setAttribute("style","display:none;");
    		//contentBase.appendChild(sourcePara);
    		contentBase.appendChild(x);

    		if(targetComponentFileMap[fileName] != undefined)
			{
    			var y = document.createElement("TEXTAREA");
        		y.setAttribute('id',newTextId);
        		y.value = targetComponentFileMap[fileName];
        		y.setAttribute("style","display:none;");
        		contentBase.appendChild(y);
			}
    		else
			{
    			var y = document.createElement("TEXTAREA");
        		y.setAttribute('id',newTextId);
        		y.value = '';
        		y.setAttribute("style","display:none;");
        		contentBase.appendChild(y);
			}
            
            var z = document.createElement("DIV");
    		z.setAttribute('id',viewDivId);
    		//viewBase.appendChild(targetPara);
    		viewBase.appendChild(z);
    		diffUsingJS(0,fileName,fileName,baseTextId,newTextId, viewDivId);
    		index++;
		}
    	
    	for(var fileName in targetComponentFileMap)
		{
    		if(sourceComponentFileMap[fileName] == undefined)
    		{
    			var baseTextId = 'baseText'+index;
        		var newTextId = 'newText'+index;
        		var viewDivId = 'diffoutput'+index;
        		
        		var x = document.createElement("TEXTAREA");
        		x.setAttribute('id',baseTextId);
        		x.value = '';
        		x.setAttribute("style","display:none;");
        		contentBase.appendChild(x);
        		
        		var y = document.createElement("TEXTAREA");
        		y.setAttribute('id',newTextId);
        		y.value = targetComponentFileMap[fileName];
        		y.setAttribute("style","display:none;");
        		contentBase.appendChild(y);
                
                var z = document.createElement("DIV");
        		z.setAttribute('id',viewDivId);

        		viewBase.appendChild(z);
        		diffUsingJS(0,fileName,fileName,baseTextId,newTextId, viewDivId);
        		index++;
    		}
		}
        
        /*var itemName = $('#itemName').html();
        var s1 = ''+source_parentName;
        var s2 = ''+target_parentName;
        //if newtxt or baseText is empty then add 'Not Exist'
        if(document.getElementById('baseText').value.trim() == '')
            s1 += ' : Not Exist';
        else
        {
        	if(source_version != undefined && source_version != '' && source_version != null)
    			s1 += ' : ' + source_fullname + ' (Version: ' + source_version + ')';
   			else
   				s1 += ' : ' + source_fullname;
   		}
        if(document.getElementById('newText').value.trim() == '')
            s2 += ' : Not Exist';
        else
        {
        	if(target_version != undefined && target_version != '' && target_version != null)
    			s2 += ' : ' + target_fullname + ' (Version: ' + target_version + ')';
   			else
        		s2 += ' : ' + target_fullname;
    	}
    	console.log('s1 ####  ' + s1);
    	console.log('s2 ####  ' + s2);
        diffUsingJS(0,s1,s2);*/
    }
    hide();
}

var childMap = {};
childMap['CustomField'] = true;
childMap['CustomLabel'] = true;
childMap['CompactLayout'] = true;
childMap['WebLink'] = true;
childMap['RecordType'] = true;
childMap['ListView'] = true;
childMap['FieldSet'] = true;
childMap['AssignmentRule'] = true;
childMap['AutoResponseRule'] = true;
childMap['ValidationRule'] = true;
childMap['WorkflowTask'] = true;
childMap['WorkflowOutboundMessage'] = true;
childMap['WorkflowFieldUpdate'] = true;
childMap['WorkflowKnowledgePublish'] = true;
childMap['WorkflowAlert'] = true;
childMap['WorkflowRule'] = true;
childMap['SharingOwnerRule'] = true;
childMap['SharingCriteriaRule'] = true;
childMap['BusinessProcess'] = true;
childMap['SharingReason'] = true;
childMap['EscalationRule'] = true;
childMap['MatchingRule'] = true;
childMap['ManagedTopic'] = true;

var folderMap = {};
folderMap['DocumentFolder'] = 'Document';
folderMap['DashboardFolder'] = 'Dashboard';
folderMap['ReportFolder'] = 'Report';
folderMap['EmailFolder'] = 'EmailTemplate';

var metadataTypeHeaderMap = {};
metadataTypeHeaderMap['CustomLabel'] = '<?xml version="1.0" encoding="UTF-8"?><CustomLabels xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['CustomField'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['CompactLayout'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['WebLink'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['RecordType'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['ListView'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['FieldSet'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['BusinessProcess'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['SharingReason'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['ValidationRule'] = '<?xml version="1.0" encoding="UTF-8"?><CustomObject xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['AssignmentRule'] = '<?xml version="1.0" encoding="UTF-8"?><AssignmentRules xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['AutoResponseRule'] = '<?xml version="1.0" encoding="UTF-8"?><AutoResponseRules xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['WorkflowTask'] = '<?xml version="1.0" encoding="UTF-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['WorkflowOutboundMessage'] = '<?xml version="1.0" encoding="UTF-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['WorkflowFieldUpdate'] = '<?xml version="1.0" encoding="UTF-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['WorkflowKnowledgePublish'] = '<?xml version="1.0" encoding="UTF-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['WorkflowAlert'] = '<?xml version="1.0" encoding="UTF-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['WorkflowRule'] = '<?xml version="1.0" encoding="UTF-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['SharingOwnerRule'] = '<?xml version="1.0" encoding="UTF-8"?><SharingRules xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['SharingCriteriaRule'] = '<?xml version="1.0" encoding="UTF-8"?><SharingRules xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['EscalationRule'] = '<?xml version="1.0" encoding="UTF-8"?><EscalationRules xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['MatchingRule'] = '<?xml version="1.0" encoding="UTF-8"?><MatchingRules xmlns="http://soap.sforce.com/2006/04/metadata">';
metadataTypeHeaderMap['ManagedTopic'] = '<?xml version="1.0" encoding="UTF-8"?><ManagedTopics xmlns="http://soap.sforce.com/2006/04/metadata">';

var metadataTypeFooterMap = {};
metadataTypeFooterMap['CustomLabel'] = '</CustomLabels>';
metadataTypeFooterMap['CustomField'] = '</CustomObject>';
metadataTypeFooterMap['CompactLayout'] = '</CustomObject>';
metadataTypeFooterMap['WebLink'] = '</CustomObject>';
metadataTypeFooterMap['RecordType'] = '</CustomObject>';
metadataTypeFooterMap['ListView'] = '</CustomObject>';
metadataTypeFooterMap['FieldSet'] = '</CustomObject>';
metadataTypeFooterMap['BusinessProcess'] = '</CustomObject>';
metadataTypeFooterMap['SharingReason'] = '</CustomObject>';
metadataTypeFooterMap['ValidationRule'] = '</CustomObject>';
metadataTypeFooterMap['AssignmentRule'] = '</AssignmentRules>';
metadataTypeFooterMap['AutoResponseRule'] = '</AutoResponseRules>';
metadataTypeFooterMap['WorkflowTask'] = '</Workflow>';
metadataTypeFooterMap['WorkflowOutboundMessage'] = '</Workflow>';
metadataTypeFooterMap['WorkflowFieldUpdate'] = '</Workflow>';
metadataTypeFooterMap['WorkflowKnowledgePublish'] = '</Workflow>';
metadataTypeFooterMap['WorkflowAlert'] = '</Workflow>';
metadataTypeFooterMap['WorkflowRule'] = '</Workflow>';
metadataTypeFooterMap['SharingOwnerRule'] = '</SharingRules>';
metadataTypeFooterMap['SharingCriteriaRule'] = '</SharingRules>';
metadataTypeFooterMap['EscalationRule'] = '</EscalationRules>';
metadataTypeFooterMap['MatchingRule'] = '</MatchingRules>';
metadataTypeFooterMap['ManagedTopic'] = '</ManagedTopics>';

var metadataTypePreTagMap = {};
metadataTypePreTagMap['CustomLabel'] = '<labels>';
metadataTypePreTagMap['CustomField'] = '<fields>';
metadataTypePreTagMap['CompactLayout'] = '<compactLayouts>';
metadataTypePreTagMap['WebLink'] = '<webLinks>';
metadataTypePreTagMap['RecordType'] = '<recordTypes>';
metadataTypePreTagMap['ListView'] = '<listViews>';
metadataTypePreTagMap['FieldSet'] = '<fieldSets>';
metadataTypePreTagMap['BusinessProcess'] = '<businessProcesses>';
metadataTypePreTagMap['SharingReason'] = '<sharingReasons>';
metadataTypePreTagMap['ValidationRule'] = '<validationRules>';
metadataTypePreTagMap['AssignmentRule'] = '<assignmentRule>';
metadataTypePreTagMap['AutoResponseRule'] = '<autoResponseRule>';
metadataTypePreTagMap['WorkflowTask'] = '<tasks>';
metadataTypePreTagMap['WorkflowOutboundMessage'] = '<outboundMessages>';
metadataTypePreTagMap['WorkflowFieldUpdate'] = '<fieldUpdates>';
metadataTypePreTagMap['WorkflowKnowledgePublish'] = '<knowledgePublishes>';
metadataTypePreTagMap['WorkflowAlert'] = '<alerts>';
metadataTypePreTagMap['WorkflowRule'] = '<rules>';
metadataTypePreTagMap['SharingOwnerRule'] = '<sharingOwnerRules>';
metadataTypePreTagMap['SharingCriteriaRule'] = '<sharingCriteriaRules>';
metadataTypePreTagMap['EscalationRule'] = '<escalationRule>';
metadataTypePreTagMap['MatchingRule'] = '<matchingRules>';
metadataTypePreTagMap['ManagedTopic'] = '<managedTopic>';

var metadataTypePostTagMap = {};
metadataTypePostTagMap['CustomLabel'] = '</labels>';
metadataTypePostTagMap['CustomField'] = '</fields>';
metadataTypePostTagMap['CompactLayout'] = '</compactLayouts>';
metadataTypePostTagMap['WebLink'] = '</webLinks>';
metadataTypePostTagMap['RecordType'] = '</recordTypes>';
metadataTypePostTagMap['ListView'] = '</listViews>';
metadataTypePostTagMap['FieldSet'] = '</fieldSets>';
metadataTypePostTagMap['BusinessProcess'] = '</businessProcesses>';
metadataTypePostTagMap['SharingReason'] = '</sharingReasons>';
metadataTypePostTagMap['ValidationRule'] = '</validationRules>';
metadataTypePostTagMap['AssignmentRule'] = '</assignmentRule>';
metadataTypePostTagMap['AutoResponseRule'] = '</autoResponseRule>';
metadataTypePostTagMap['WorkflowTask'] = '</tasks>';
metadataTypePostTagMap['WorkflowOutboundMessage'] = '</outboundMessages>';
metadataTypePostTagMap['WorkflowFieldUpdate'] = '</fieldUpdates>';
metadataTypePostTagMap['WorkflowKnowledgePublish'] = '</knowledgePublishes>';
metadataTypePostTagMap['WorkflowAlert'] = '</alerts>';
metadataTypePostTagMap['WorkflowRule'] = '</rules>';
metadataTypePostTagMap['SharingOwnerRule'] = '</sharingOwnerRules>';
metadataTypePostTagMap['SharingCriteriaRule'] = '</sharingCriteriaRules>';
metadataTypePostTagMap['EscalationRule'] = '</escalationRule>';
metadataTypePostTagMap['MatchingRule'] = '</matchingRules>';
metadataTypePostTagMap['ManagedTopic'] = '</managedTopic>';

function formatXml(xml) {
    var formatted = '';
    var reg = /(>)(<)(\/*)/g;
    xml = xml.replace(reg, '$1\r\n$2$3');
    var pad = 0;
    jQuery.each(xml.split('\r\n'), function(index, node) {
        var indent = 0;
        if (node.match( /.+<\/\w[^>]*>$/ )) {
            indent = 0;
        } else if (node.match( /^<\/\w/ )) {
            if (pad != 0) {
                pad -= 1;
            }
        } else if (node.match( /^<\w[^>]*[^\/]>.*$/ )) {
            indent = 1;
        } else {
            indent = 0;
        }

        var padding = '';
        for (var i = 0; i < pad; i++) {
            padding += '  ';
        }

        formatted += padding + node + '\r\n';
        pad += indent;
    });

    return formatted;
}

function childSplitter(fullXml,metaType,fileName)
{
	var childDataMap = {};
	if(fullXml != undefined)
	{
		var fullName = '';
		if(metaType != 'CustomLabel')
		{
			fullName = fileName.slice(fileName.indexOf("/")+1,fileName.lastIndexOf('.'))+".";
		}
		var x2js = new X2JS();
		var tgtmap = {};
		var srcjson = x2js.xml_str2json(fullXml);
		if(srcjson != null)
		{
			var srcitems;
			if(metaType == 'CustomLabel')
			{
				var srcMetaItem = srcjson.CustomLabels;
				srcitems = srcMetaItem.labels;
			}
			else if(metaType == 'CustomField')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.fields;
			}
			else if(metaType == 'ListView')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.listViews;
			}
			else if(metaType == 'CompactLayout')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.compactLayouts;
			}
			else if(metaType == 'WebLink')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.webLinks;
			}
			else if(metaType == 'RecordType')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.recordTypes;
			}
			else if(metaType == 'FieldSet')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.fieldSets;
			}
			else if(metaType == 'ValidationRule')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.validationRules;
			}
			else if(metaType == 'AssignmentRule')
			{
				var srcMetaItem = srcjson.AssignmentRules;
				srcitems = srcMetaItem.assignmentRule;
			}
			else if(metaType == 'AutoResponseRule')
			{
				var srcMetaItem = srcjson.AutoResponseRules;
				srcitems = srcMetaItem.autoResponseRule;
			}
			else if(metaType == 'WorkflowTask')
			{
				var srcMetaItem = srcjson.Workflow;
				srcitems = srcMetaItem.tasks;
			}
			else if(metaType == 'WorkflowOutboundMessage')
			{
				var srcMetaItem = srcjson.Workflow;
				srcitems = srcMetaItem.outboundMessages;
			}
			else if(metaType == 'WorkflowFieldUpdate')
			{
				var srcMetaItem = srcjson.Workflow;
				srcitems = srcMetaItem.fieldUpdates;
			}
			else if(metaType == 'WorkflowKnowledgePublish')
			{
				var srcMetaItem = srcjson.Workflow;
				srcitems = srcMetaItem.knowledgePublishes;
			}
			else if(metaType == 'WorkflowAlert')
			{
				var srcMetaItem = srcjson.Workflow;
				srcitems = srcMetaItem.alerts;
			}
			else if( metaType == 'WorkflowRule')
			{
				var srcMetaItem = srcjson.Workflow;
				srcitems = srcMetaItem.rules;
			}
			else if(metaType == 'SharingCriteriaRule')
			{
				var srcMetaItem = srcjson.SharingRules;
				srcitems = srcMetaItem.sharingCriteriaRules;
			}
			else if(metaType == 'SharingOwnerRule')
			{
				var srcMetaItem = srcjson.SharingRules;
				srcitems = srcMetaItem.sharingOwnerRules;
			}
			else if(metaType == 'BusinessProcess')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.businessProcesses;
			}
			else if(metaType == 'SharingReason')
			{
				var srcMetaItem = srcjson.CustomObject;
				srcitems = srcMetaItem.sharingReasons;
			}
			else if(metaType == 'EscalationRule')
			{
				var srcMetaItem = srcjson.EscalationRules;
				srcitems = srcMetaItem.escalationRule;
			}
			else if(metaType == 'MatchingRule')
			{
				var srcMetaItem = srcjson.MatchingRules;
				srcitems = srcMetaItem.matchingRules;
			}
			else if(metaType == 'ManagedTopic')
			{
				var srcMetaItem = srcjson.ManagedTopics;
				srcitems = srcMetaItem.ManagedTopic;
			}
			if(srcitems != undefined)
			{
				if(srcitems.fullName == undefined)
				{			    	
					$.each(srcitems, function( i, v )
					{
						tgtmap[fullName+''+v.fullName] = JSON.stringify(v);
					});  
				}
				else
				{
					tgtmap[fullName+''+srcitems.fullName] = JSON.stringify(srcitems);
				}
			}
			if(metadataTypeHeaderMap[metaType] != undefined && metadataTypePreTagMap[metaType]  != undefined && metadataTypePostTagMap[metaType]  != undefined && metadataTypeFooterMap[metaType] != undefined)
			{
				for(var itemName in tgtmap)
				{
					tempXml = '';
					//header
					tempXml = metadataTypeHeaderMap[metaType];
					//body
					tempXml += metadataTypePreTagMap[metaType]+''+x2js.json2xml_str($.parseJSON(tgtmap[itemName]))+''+metadataTypePostTagMap[metaType];
					//footer
					tempXml += metadataTypeFooterMap[metaType];
					if(tempXml != '')
					{
						childDataMap[metaType+'#'+itemName] = formatXml(tempXml);
					}
				}
			}
		}
	}
	return childDataMap;
}

function isEmpty(obj) {
    for(var key in obj) {
        if(obj.hasOwnProperty(key))
            return false;
    }
    return true;
}

function diffUsingJS(viewType,source,target,baseTextId,newTextId,viewDivId,ignoreWS) {
    "use strict";
    var byId = function (id) { return document.getElementById(id); };
    var    base = difflib.stringAsLines(byId(baseTextId).value);
    var    newtxt = difflib.stringAsLines(byId(newTextId).value);
    var    compareBase,  compareNewtxt;
    if (ignoreWS != undefined && ignoreWS){
	if (base != undefined && base.length > 0 ){
		compareBase = [];
		for (var x = 0; x <  base.length; x++){
			compareBase.push(base[x].trim());
		}
	}else{
		compareBase = base;	
	}	
	if (newtxt != undefined && newtxt.length > 0 ){
		compareNewtxt = [];
		for (var x = 0; x <  newtxt.length; x++){
			compareNewtxt.push(newtxt[x].trim());
		}
	}else{
		compareNewtxt = base;	
	}	
    }else{
	compareBase = base;
	compareNewtxt = newtxt;
    }

    var    sm = new difflib.SequenceMatcher(compareBase, compareNewtxt);
    var    opcodes = sm.get_opcodes();
    var    diffoutputdiv = byId(viewDivId);
    var    contextSize = byId("contextSize").value;

    diffoutputdiv.innerHTML = "";
    contextSize = contextSize || null;

    diffoutputdiv.appendChild(diffview.buildView({
        baseTextLines: base,
        newTextLines: newtxt,
        opcodes: opcodes,
        baseTextName: source,
        newTextName: target,
        contextSize: contextSize,
        viewType: viewType
    }));
}


// Main course

diffview = {
    /**
     * Builds and returns a visual diff view.  The single parameter, `params', should contain
     * the following values:
     *
     * - baseTextLines: the array of strings that was used as the base text input to SequenceMatcher
     * - newTextLines: the array of strings that was used as the new text input to SequenceMatcher
     * - opcodes: the array of arrays returned by SequenceMatcher.get_opcodes()
     * - baseTextName: the title to be displayed above the base text listing in the diff view; defaults
     *     to "Base Text"
     * - newTextName: the title to be displayed above the new text listing in the diff view; defaults
     *     to "New Text"
     * - contextSize: the number of lines of context to show around differences; by default, all lines
     *     are shown
     * - viewType: if 0, a side-by-side diff view is generated (default); if 1, an inline diff view is
     *     generated
     */
    buildView: function (params) {
        var baseTextLines = params.baseTextLines;
        var newTextLines = params.newTextLines;
        var opcodes = params.opcodes;
        var baseTextName = params.baseTextName ? params.baseTextName : "Base Text";
        var newTextName = params.newTextName ? params.newTextName : "New Text";
        var contextSize = params.contextSize;
        var inline = (params.viewType == 0 || params.viewType == 1) ? params.viewType : 0;

        if (baseTextLines == null)
            throw "Cannot build diff view; baseTextLines is not defined.";
        if (newTextLines == null)
            throw "Cannot build diff view; newTextLines is not defined.";
        if (!opcodes)
            throw "Canno build diff view; opcodes is not defined.";
        
        function celt (name, clazz) {
            var e = document.createElement(name);
            e.className = clazz;
            return e;
        }
        
        function telt (name, text) {
            var e = document.createElement(name);
            e.appendChild(document.createTextNode(text));
            return e;
        }
        
        function ctelt (name, clazz, text) {
            var e = document.createElement(name);
            e.className = clazz;
            e.appendChild(document.createTextNode(text));
            return e;
        }
    
        var tdata = document.createElement("thead");
        var node = document.createElement("tr");
        tdata.appendChild(node);
        if (inline) {
            node.appendChild(document.createElement("th"));
            node.appendChild(document.createElement("th"));
            node.appendChild(ctelt("th", "texttitle", baseTextName + " vs. " + newTextName));
        } else {
            node.appendChild(ctelt("th", "emptytitle",''));
            node.appendChild(ctelt("th", "texttitle", baseTextName));
            node.appendChild(ctelt("th", "emptytitle",''));
            node.appendChild(ctelt("th", "texttitle", newTextName));
        }
        tdata = [tdata];
        
        var rows = [];
        var node2;
        
        /**
         * Adds two cells to the given row; if the given row corresponds to a real
         * line number (based on the line index tidx and the endpoint of the 
         * range in question tend), then the cells will contain the line number
         * and the line of text from textLines at position tidx (with the class of
         * the second cell set to the name of the change represented), and tidx + 1 will
         * be returned.  Otherwise, tidx is returned, and two empty cells are added
         * to the given row.
         */
        function addCells (row, tidx, tend, textLines, change) {
            if (tidx < tend) {
                row.appendChild(telt("th", (tidx + 1).toString()));
                row.appendChild(ctelt("td", change, textLines[tidx].replace(/\t/g, "\u00a0\u00a0\u00a0\u00a0")));
                return tidx + 1;
            } else {
                row.appendChild(document.createElement("th"));
                row.appendChild(celt("td", "empty"));
                return tidx;
            }
        }
        
        function addCellsInline (row, tidx, tidx2, textLines, change) {
            row.appendChild(telt("th", tidx == null ? "" : (tidx + 1).toString()));
            row.appendChild(telt("th", tidx2 == null ? "" : (tidx2 + 1).toString()));
            row.appendChild(ctelt("td", change, textLines[tidx != null ? tidx : tidx2].replace(/\t/g, "\u00a0\u00a0\u00a0\u00a0")));
        }
        
        for (var idx = 0; idx < opcodes.length; idx++) {
            code = opcodes[idx];
            change = code[0];
            var b = code[1];
            var be = code[2];
            var n = code[3];
            var ne = code[4];
            var rowcnt = Math.max(be - b, ne - n);
            var toprows = [];
            var botrows = [];
            for (var i = 0; i < rowcnt; i++) {
                // jump ahead if we've alredy provided leading context or if this is the first range
                if (contextSize && opcodes.length > 1 && ((idx > 0 && i == contextSize) || (idx == 0 && i == 0)) && change=="equal") {
                    var jump = rowcnt - ((idx == 0 ? 1 : 2) * contextSize);
                    if (jump > 1) {
                        toprows.push(node = document.createElement("tr"));
                        
                        b += jump;
                        n += jump;
                        i += jump - 1;
                        node.appendChild(telt("th", "..."));
                        if (!inline) node.appendChild(ctelt("td", "skip", ""));
                        node.appendChild(telt("th", "..."));
                        node.appendChild(ctelt("td", "skip", ""));
                        
                        // skip last lines if they're all equal
                        if (idx + 1 == opcodes.length) {
                            break;
                        } else {
                            continue;
                        }
                    }
                }
                
                toprows.push(node = document.createElement("tr"));
                if (inline) {
                    if (change == "insert") {
                        addCellsInline(node, null, n++, newTextLines, change);
                    } else if (change == "replace") {
                        botrows.push(node2 = document.createElement("tr"));
                        if (b < be) addCellsInline(node, b++, null, baseTextLines, "delete");
                        if (n < ne) addCellsInline(node2, null, n++, newTextLines, "insert");
                    } else if (change == "delete") {
                        addCellsInline(node, b++, null, baseTextLines, change);
                    } else {
                        // equal
                        addCellsInline(node, b++, n++, baseTextLines, change);
                    }
                } else {
                    b = addCells(node, b, be, baseTextLines, change);
                    n = addCells(node, n, ne, newTextLines, change);
                }
            }

            for (var i = 0; i < toprows.length; i++) rows.push(toprows[i]);
            for (var i = 0; i < botrows.length; i++) rows.push(botrows[i]);
        }
        
        //rows.push(node = ctelt("th", "author", "diff view generated by "));
        //node.setAttribute("colspan", inline ? 3 : 4);
        //node.appendChild(node2 = telt("a", "jsdifflib"));
        //node2.setAttribute("href", "http://github.com/cemerick/jsdifflib");
        
        tdata.push(node = document.createElement("tbody"));
        for (var idx in rows) rows.hasOwnProperty(idx) && node.appendChild(rows[idx]);
        
        node = celt("table", "diff" + (inline ? " inlinediff" : ""));
        for (var idx in tdata) tdata.hasOwnProperty(idx) && node.appendChild(tdata[idx]);
        return node;
    }
};


__whitespace = {" ":true, "\t":true, "\n":true, "\f":true, "\r":true};

difflib = {
    defaultJunkFunction: function (c) {
        return __whitespace.hasOwnProperty(c);
    },
    
    stripLinebreaks: function (str) { return str.replace(/^[\n\r]*|[\n\r]*$/g, ""); },
    
    stringAsLines: function (str) {
        var lfpos = str.indexOf("\n");
        var crpos = str.indexOf("\r");
        var linebreak = ((lfpos > -1 && crpos > -1) || crpos < 0) ? "\n" : "\r";
        
        var lines = str.split(linebreak);
        for (var i = 0; i < lines.length; i++) {
            lines[i] = difflib.stripLinebreaks(lines[i]);
        }
        
        return lines;
    },
    
    // iteration-based reduce implementation
    __reduce: function (func, list, initial) {
        if (initial != null) {
            var value = initial;
            var idx = 0;
        } else if (list) {
            var value = list[0];
            var idx = 1;
        } else {
            return null;
        }
        
        for (; idx < list.length; idx++) {
            value = func(value, list[idx]);
        }
        
        return value;
    },
    
    // comparison function for sorting lists of numeric tuples
    __ntuplecomp: function (a, b) {
        var mlen = Math.max(a.length, b.length);
        for (var i = 0; i < mlen; i++) {
            if (a[i] < b[i]) return -1;
            if (a[i] > b[i]) return 1;
        }
        
        return a.length == b.length ? 0 : (a.length < b.length ? -1 : 1);
    },
    
    __calculate_ratio: function (matches, length) {
        return length ? 2.0 * matches / length : 1.0;
    },
    
    // returns a function that returns true if a key passed to the returned function
    // is in the dict (js object) provided to this function; replaces being able to
    // carry around dict.has_key in python...
    __isindict: function (dict) {
        return function (key) { return dict.hasOwnProperty(key); };
    },
    
    // replacement for python's dict.get function -- need easy default values
    __dictget: function (dict, key, defaultValue) {
        return dict.hasOwnProperty(key) ? dict[key] : defaultValue;
    },  
    
    SequenceMatcher: function (a, b, isjunk) {
        this.set_seqs = function (a, b) {
            this.set_seq1(a);
            this.set_seq2(b);
        }
        
        this.set_seq1 = function (a) {
            if (a == this.a) return;
            this.a = a;
            this.matching_blocks = this.opcodes = null;
        }
        
        this.set_seq2 = function (b) {
            if (b == this.b) return;
            this.b = b;
            this.matching_blocks = this.opcodes = this.fullbcount = null;
            this.__chain_b();
        }
        
        this.__chain_b = function () {
            var b = this.b;
            var n = b.length;
            var b2j = this.b2j = {};
            var populardict = {};
            for (var i = 0; i < b.length; i++) {
                var elt = b[i];
                if (b2j.hasOwnProperty(elt)) {
                    var indices = b2j[elt];
                    if (n >= 200 && indices.length * 100 > n) {
                        populardict[elt] = 1;
                        delete b2j[elt];
                    } else {
                        indices.push(i);
                    }
                } else {
                    b2j[elt] = [i];
                }
            }
    
            for (var elt in populardict) {
                if (populardict.hasOwnProperty(elt)) {
                    delete b2j[elt];
                }
            }
            
            var isjunk = this.isjunk;
            var junkdict = {};
            if (isjunk) {
                for (var elt in populardict) {
                    if (populardict.hasOwnProperty(elt) && isjunk(elt)) {
                        junkdict[elt] = 1;
                        delete populardict[elt];
                    }
                }
                for (var elt in b2j) {
                    if (b2j.hasOwnProperty(elt) && isjunk(elt)) {
                        junkdict[elt] = 1;
                        delete b2j[elt];
                    }
                }
            }
    
            this.isbjunk = difflib.__isindict(junkdict);
            this.isbpopular = difflib.__isindict(populardict);
        }
        
        this.find_longest_match = function (alo, ahi, blo, bhi) {
            var a = this.a;
            var b = this.b;
            var b2j = this.b2j;
            var isbjunk = this.isbjunk;
            var besti = alo;
            var bestj = blo;
            var bestsize = 0;
            var j = null;
    
            var j2len = {};
            var nothing = [];
            for (var i = alo; i < ahi; i++) {
                var newj2len = {};
                var jdict = difflib.__dictget(b2j, a[i], nothing);
                for (var jkey in jdict) {
                    if (jdict.hasOwnProperty(jkey)) {
                        j = jdict[jkey];
                        if (j < blo) continue;
                        if (j >= bhi) break;
                        newj2len[j] = k = difflib.__dictget(j2len, j - 1, 0) + 1;
                        if (k > bestsize) {
                            besti = i - k + 1;
                            bestj = j - k + 1;
                            bestsize = k;
                        }
                    }
                }
                j2len = newj2len;
            }
    
            while (besti > alo && bestj > blo && !isbjunk(b[bestj - 1]) && a[besti - 1] == b[bestj - 1]) {
                besti--;
                bestj--;
                bestsize++;
            }
                
            while (besti + bestsize < ahi && bestj + bestsize < bhi &&
                    !isbjunk(b[bestj + bestsize]) &&
                    a[besti + bestsize] == b[bestj + bestsize]) {
                bestsize++;
            }
    
            while (besti > alo && bestj > blo && isbjunk(b[bestj - 1]) && a[besti - 1] == b[bestj - 1]) {
                besti--;
                bestj--;
                bestsize++;
            }
            
            while (besti + bestsize < ahi && bestj + bestsize < bhi && isbjunk(b[bestj + bestsize]) &&
                    a[besti + bestsize] == b[bestj + bestsize]) {
                bestsize++;
            }
    
            return [besti, bestj, bestsize];
        }
        
        this.get_matching_blocks = function () {
            if (this.matching_blocks != null) return this.matching_blocks;
            var la = this.a.length;
            var lb = this.b.length;
    
            var queue = [[0, la, 0, lb]];
            var matching_blocks = [];
            var alo, ahi, blo, bhi, qi, i, j, k, x;
            while (queue.length) {
                qi = queue.pop();
                alo = qi[0];
                ahi = qi[1];
                blo = qi[2];
                bhi = qi[3];
                x = this.find_longest_match(alo, ahi, blo, bhi);
                i = x[0];
                j = x[1];
                k = x[2];
    
                if (k) {
                    matching_blocks.push(x);
                    if (alo < i && blo < j)
                        queue.push([alo, i, blo, j]);
                    if (i+k < ahi && j+k < bhi)
                        queue.push([i + k, ahi, j + k, bhi]);
                }
            }
            
            matching_blocks.sort(difflib.__ntuplecomp);
    
            var i1 = j1 = k1 = block = 0;
            var non_adjacent = [];
            for (var idx in matching_blocks) {
                if (matching_blocks.hasOwnProperty(idx)) {
                    block = matching_blocks[idx];
                    i2 = block[0];
                    j2 = block[1];
                    k2 = block[2];
                    if (i1 + k1 == i2 && j1 + k1 == j2) {
                        k1 += k2;
                    } else {
                        if (k1) non_adjacent.push([i1, j1, k1]);
                        i1 = i2;
                        j1 = j2;
                        k1 = k2;
                    }
                }
            }
            
            if (k1) non_adjacent.push([i1, j1, k1]);
    
            non_adjacent.push([la, lb, 0]);
            this.matching_blocks = non_adjacent;
            return this.matching_blocks;
        }
        
        this.get_opcodes = function () {
            if (this.opcodes != null) return this.opcodes;
            var i = 0;
            var j = 0;
            var answer = [];
            this.opcodes = answer;
            var block, ai, bj, size, tag;
            var blocks = this.get_matching_blocks();
            for (var idx in blocks) {
                if (blocks.hasOwnProperty(idx)) {
                    block = blocks[idx];
                    ai = block[0];
                    bj = block[1];
                    size = block[2];
                    tag = '';
                    if (i < ai && j < bj) {
                        tag = 'replace';
                    } else if (i < ai) {
                        tag = 'delete';
                    } else if (j < bj) {
                        tag = 'insert';
                    }
                    if (tag) answer.push([tag, i, ai, j, bj]);
                    i = ai + size;
                    j = bj + size;
                    
                    if (size) answer.push(['equal', ai, i, bj, j]);
                }
            }
            
            return answer;
        }
        
        // this is a generator function in the python lib, which of course is not supported in javascript
        // the reimplementation builds up the grouped opcodes into a list in their entirety and returns that.
        this.get_grouped_opcodes = function (n) {
            if (!n) n = 3;
            var codes = this.get_opcodes();
            if (!codes) codes = [["equal", 0, 1, 0, 1]];
            var code, tag, i1, i2, j1, j2;
            if (codes[0][0] == 'equal') {
                code = codes[0];
                tag = code[0];
                i1 = code[1];
                i2 = code[2];
                j1 = code[3];
                j2 = code[4];
                codes[0] = [tag, Math.max(i1, i2 - n), i2, Math.max(j1, j2 - n), j2];
            }
            if (codes[codes.length - 1][0] == 'equal') {
                code = codes[codes.length - 1];
                tag = code[0];
                i1 = code[1];
                i2 = code[2];
                j1 = code[3];
                j2 = code[4];
                codes[codes.length - 1] = [tag, i1, Math.min(i2, i1 + n), j1, Math.min(j2, j1 + n)];
            }
    
            var nn = n + n;
            var group = [];
            var groups = [];
            for (var idx in codes) {
                if (codes.hasOwnProperty(idx)) {
                    code = codes[idx];
                    tag = code[0];
                    i1 = code[1];
                    i2 = code[2];
                    j1 = code[3];
                    j2 = code[4];
                    if (tag == 'equal' && i2 - i1 > nn) {
                        group.push([tag, i1, Math.min(i2, i1 + n), j1, Math.min(j2, j1 + n)]);
                        groups.push(group);
                        group = [];
                        i1 = Math.max(i1, i2-n);
                        j1 = Math.max(j1, j2-n);
                    }
                    
                    group.push([tag, i1, i2, j1, j2]);
                }
            }
            
            if (group && !(group.length == 1 && group[0][0] == 'equal')) groups.push(group)
            
            return groups;
        }
        
        this.ratio = function () {
            matches = difflib.__reduce(
                            function (sum, triple) { return sum + triple[triple.length - 1]; },
                            this.get_matching_blocks(), 0);
            return difflib.__calculate_ratio(matches, this.a.length + this.b.length);
        }
        
        this.quick_ratio = function () {
            var fullbcount, elt;
            if (this.fullbcount == null) {
                this.fullbcount = fullbcount = {};
                for (var i = 0; i < this.b.length; i++) {
                    elt = this.b[i];
                    fullbcount[elt] = difflib.__dictget(fullbcount, elt, 0) + 1;
                }
            }
            fullbcount = this.fullbcount;
    
            var avail = {};
            var availhas = difflib.__isindict(avail);
            var matches = numb = 0;
            for (var i = 0; i < this.a.length; i++) {
                elt = this.a[i];
                if (availhas(elt)) {
                    numb = avail[elt];
                } else {
                    numb = difflib.__dictget(fullbcount, elt, 0);
                }
                avail[elt] = numb - 1;
                if (numb > 0) matches++;
            }
            
            return difflib.__calculate_ratio(matches, this.a.length + this.b.length);
        }
        
        this.real_quick_ratio = function () {
            var la = this.a.length;
            var lb = this.b.length;
            return _calculate_ratio(Math.min(la, lb), la + lb);
        }
        
        this.isjunk = isjunk ? isjunk : difflib.defaultJunkFunction;
        this.a = this.b = null;
        this.set_seqs(a, b);
    }
};
