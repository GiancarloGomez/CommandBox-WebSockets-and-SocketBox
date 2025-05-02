component {
	this.name              = "site2";
	this.sessionManagement = true;

	this.mappings = {
		"/modules" = expandPath( "../modules" )
	};
}