component {
	this.name              = "site1";
	this.sessionManagement = true;

	this.mappings = {
		"/modules" = expandPath( "../modules" )
	};
}