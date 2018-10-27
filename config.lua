--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

application =
{
	content =
	{
		scale = "adaptive",
		fps = 60,
		
		imageSuffix =
		{
			    ["@2x"] = 1.5,
			    ["@3x"] = 2.5,
		},
	},
	license =
    {
        google =
        {
            key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAgPFbJbA5I5Gi/MONFdDkwMk+9M3kHDpp6OR7wFpLdx2CLDdQsZ0nnIAKjHrZQAzoz4bEZizfb0mWx2aR68cQ6jDzLAHiApU/sjllfXWQR4BhtrkMWViSg2N6pzt2GuAyX4/j0ixs6nq6g89rC7eRL4xW69HFny1I+uuocxw/R30Zcfn8XLYqHeHDfHa+Rp5ugxDnOJkBVbqNzDCPwO3S+PWOdJVuEFWymS5EYjIL34449M01pPqS7He3Y204IgMjn/z828O/3CthGQax/ZCbr8+eDu+JNc6+PO8bBLjIBgBBMbEuQUd9uhwVpB476obWMvr+niVs7YctfW3/FOFzVwIDAQAB",
			policy = "serverManaged",
			mapsKey = "AIzaSyDhT7e_T7IEpDCmWnINQbjJc8lsBuaj8-A",
        },
    },
}
