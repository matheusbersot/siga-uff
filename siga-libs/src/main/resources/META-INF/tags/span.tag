<%@ tag body-content="scriptless"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="ww" uri="/webwork"%>
<%@ attribute name="id" required="true"%>
<%@ attribute name="depende"%>
<span id="${id}" depende=";${depende};"><!--ajax:${id}--><jsp:doBody/><!--/ajax:${id}--></span>