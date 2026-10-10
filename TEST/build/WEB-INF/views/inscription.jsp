<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<form action="${pageContext.request.contextPath}/inscription" method="POST">
  <input type="text" name="nom" placeholder="Nom" required />
  <input type="number" name="age" placeholder="Âge" required />
  <button type="submit">Envoyer</button>
</form>
